import {
  Injectable,
  NotFoundException,
  Logger,
  InternalServerErrorException,
  ForbiddenException,
  ConflictException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateReviewDto } from './dto/create-review.dto';
import { UpdateReviewDto } from './dto/update-review.dto';

const userSelect = {
  id: true,
  username: true,
  createdAt: true,
};

@Injectable()
export class ReviewsService {
  private readonly logger = new Logger(ReviewsService.name);

  constructor(private readonly prisma: PrismaService) {}

  async create(userId: number, createReviewDto: CreateReviewDto) {
    try {
      const company = await this.prisma.company.findUnique({
        where: { id: createReviewDto.companyId },
      });

      if (!company) {
        throw new NotFoundException(
          `Company with ID ${createReviewDto.companyId} not found`,
        );
      }

      // Check for existing review by this user for this company
      const existing = await this.prisma.review.findFirst({
        where: { userId, companyId: createReviewDto.companyId },
      });

      if (existing) {
        throw new ConflictException({
          message: 'Vous avez déjà laissé un avis pour cette entreprise',
          reviewId: existing.id,
        });
      }

      const review = await this.prisma.review.create({
        data: {
          rating: createReviewDto.rating,
          comment: createReviewDto.comment ?? '',
          userId,
          companyId: createReviewDto.companyId,
        },
        include: {
          user: { select: userSelect },
          company: { select: { id: true, name: true, slug: true } },
        },
      });

      return review;
    } catch (error) {
      if (
        error instanceof NotFoundException ||
        error instanceof ConflictException
      ) {
        throw error;
      }
      this.logger.error('Failed to create review', error);
      throw new InternalServerErrorException('Failed to create review');
    }
  }

  async update(id: number, userId: number, updateReviewDto: UpdateReviewDto) {
    try {
      const review = await this.prisma.review.findUnique({ where: { id } });

      if (!review) {
        throw new NotFoundException(`Review with ID ${id} not found`);
      }

      if (review.userId !== userId) {
        throw new ForbiddenException('You cannot edit this review');
      }

      const updated = await this.prisma.review.update({
        where: { id },
        data: {
          rating: updateReviewDto.rating,
          comment: updateReviewDto.comment ?? '',
        },
        include: {
          user: { select: userSelect },
          company: { select: { id: true, name: true, slug: true } },
        },
      });

      return updated;
    } catch (error) {
      if (
        error instanceof NotFoundException ||
        error instanceof ForbiddenException
      ) {
        throw error;
      }
      this.logger.error(`Failed to update review ${id}`, error);
      throw new InternalServerErrorException('Failed to update review');
    }
  }

  async findByCompany(companyId: number, rating?: number) {
    try {
      const where: any = { companyId };
      if (rating) where.rating = rating;

      return await this.prisma.review.findMany({
        where,
        include: { user: { select: userSelect } },
        orderBy: { createdAt: 'desc' },
      });
    } catch (error) {
      this.logger.error(`Failed to fetch reviews for company ${companyId}`, error);
      throw new InternalServerErrorException('Failed to fetch reviews');
    }
  }

  async findOne(id: number) {
    try {
      return await this.prisma.review.findUnique({
        where: { id },
        include: {
          user: { select: userSelect },
          company: { select: { id: true, name: true, slug: true } },
        },
      });
    } catch (error) {
      this.logger.error(`Failed to fetch review with ID ${id}`, error);
      throw new InternalServerErrorException('Failed to fetch review');
    }
  }

  async vote(id: number, type: 'upvote' | 'downvote') {
    try {
      const review = await this.prisma.review.findUnique({ where: { id } });

      if (!review) {
        throw new NotFoundException(`Review with ID ${id} not found`);
      }

      const updateData =
        type === 'upvote'
          ? { upvotes: review.upvotes + 1 }
          : { downvotes: review.downvotes + 1 };

      return await this.prisma.review.update({
        where: { id },
        data: updateData,
        include: { user: { select: userSelect } },
      });
    } catch (error) {
      if (error instanceof NotFoundException) throw error;
      this.logger.error(`Failed to vote on review ${id}`, error);
      throw new InternalServerErrorException('Failed to vote on review');
    }
  }

  async delete(id: number, userId: number, userRole: string) {
    try {
      const review = await this.prisma.review.findUnique({ where: { id } });

      if (!review) {
        throw new NotFoundException(`Review with ID ${id} not found`);
      }

      if (review.userId !== userId && userRole !== 'ADMIN') {
        throw new ForbiddenException('You do not have permission to delete this review');
      }

      await this.prisma.review.delete({ where: { id } });
      return { message: 'Review deleted successfully' };
    } catch (error) {
      if (
        error instanceof NotFoundException ||
        error instanceof ForbiddenException
      ) {
        throw error;
      }
      this.logger.error(`Failed to delete review ${id}`, error);
      throw new InternalServerErrorException('Failed to delete review');
    }
  }
}
