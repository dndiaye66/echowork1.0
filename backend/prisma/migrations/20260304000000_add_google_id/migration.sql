-- AlterTable: add googleId column (nullable, unique)
ALTER TABLE "User" ADD COLUMN "googleId" TEXT;

CREATE UNIQUE INDEX "User_googleId_key" ON "User"("googleId");
