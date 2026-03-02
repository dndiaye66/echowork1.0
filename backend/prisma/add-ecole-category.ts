import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

function createSlug(text: string): string {
  return text
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .substring(0, 100);
}

async function main() {
  const categoryName = 'Ecole et Enseignement Superieure';
  const categorySlug = createSlug(categoryName);

  const existing = await prisma.category.findUnique({ where: { slug: categorySlug } });

  if (existing) {
    console.log(`✓ Catégorie "${categoryName}" existe déjà (ID: ${existing.id})`);
    return;
  }

  const category = await prisma.category.create({
    data: { name: categoryName, slug: categorySlug },
  });

  console.log(`✓ Catégorie créée : "${categoryName}" (ID: ${category.id}, slug: ${categorySlug})`);

  const keywords = [
    'ecole', 'école', 'lycée', 'lycee', 'collège', 'college',
    'université', 'universite', 'enseignement', 'formation',
    'académie', 'academie', 'faculté', 'faculte', 'supérieur',
    'superieur', 'études', 'etudes', 'campus',
  ];

  for (const keyword of keywords) {
    await prisma.categoryKeyword.create({
      data: { categoryId: category.id, keyword: keyword.toLowerCase() },
    });
    console.log(`  ✓ Mot-clé ajouté : ${keyword}`);
  }

  console.log('\n=== Terminé ===');
}

main()
  .catch((e) => { console.error(e); process.exit(1); })
  .finally(async () => { await prisma.$disconnect(); });
