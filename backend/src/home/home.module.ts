import { Module } from '@nestjs/common';
import { HomeController } from './home.controller';
import { CompaniesModule } from '../companies/companies.module';
import { PrismaModule } from '../prisma/prisma.module';

@Module({
  imports: [CompaniesModule, PrismaModule],
  controllers: [HomeController],
})
export class HomeModule {}
