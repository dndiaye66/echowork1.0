import {
  Controller,
  Get,
  Post,
  Patch,
  Delete,
  Body,
  Param,
  Query,
  UseGuards,
  Request,
  ParseIntPipe,
} from '@nestjs/common';
import { ReviewsService } from './reviews.service';
import { CreateReviewDto } from './dto/create-review.dto';
import { UpdateReviewDto } from './dto/update-review.dto';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';

@Controller('reviews')
export class ReviewsController {
  constructor(private readonly reviewsService: ReviewsService) {}

  /** POST /api/reviews — Create review (auth required) */
  @Post()
  @UseGuards(JwtAuthGuard)
  async create(@Request() req: any, @Body() createReviewDto: CreateReviewDto) {
    return this.reviewsService.create(req.user.id, createReviewDto);
  }

  /** PATCH /api/reviews/:id — Update own review (auth required) */
  @Patch(':id')
  @UseGuards(JwtAuthGuard)
  async update(
    @Param('id', ParseIntPipe) id: number,
    @Request() req: any,
    @Body() updateReviewDto: UpdateReviewDto,
  ) {
    return this.reviewsService.update(id, req.user.id, updateReviewDto);
  }

  /** GET /api/reviews/company/:companyId */
  @Get('company/:companyId')
  async findByCompany(
    @Param('companyId', ParseIntPipe) companyId: number,
    @Query('rating') rating?: string,
  ) {
    const ratingNumber = rating ? parseInt(rating, 10) : undefined;
    return this.reviewsService.findByCompany(companyId, ratingNumber);
  }

  /** GET /api/reviews/:id */
  @Get(':id')
  async findOne(@Param('id', ParseIntPipe) id: number) {
    return this.reviewsService.findOne(id);
  }

  /** POST /api/reviews/:id/upvote */
  @Post(':id/upvote')
  async upvote(@Param('id', ParseIntPipe) id: number) {
    return this.reviewsService.vote(id, 'upvote');
  }

  /** POST /api/reviews/:id/downvote */
  @Post(':id/downvote')
  async downvote(@Param('id', ParseIntPipe) id: number) {
    return this.reviewsService.vote(id, 'downvote');
  }

  /** DELETE /api/reviews/:id (auth required) */
  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  async delete(@Param('id', ParseIntPipe) id: number, @Request() req: any) {
    return this.reviewsService.delete(id, req.user.id, req.user.role);
  }
}
