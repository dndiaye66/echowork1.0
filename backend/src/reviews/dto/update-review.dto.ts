import { IsInt, IsNotEmpty, IsOptional, IsString, Max, Min } from 'class-validator';

export class UpdateReviewDto {
  @IsInt({ message: 'Rating must be an integer' })
  @Min(1, { message: 'Rating must be at least 1' })
  @Max(5, { message: 'Rating must be at most 5' })
  @IsNotEmpty({ message: 'Rating is required' })
  rating!: number;

  @IsString({ message: 'Comment must be a string' })
  @IsOptional()
  comment?: string;
}
