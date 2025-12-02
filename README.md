# aodai

A new Flutter project.

git checkout -b gh-pages 2>/dev/null || git checkout gh-pages
rm -rf !(build|.git) && cp -r build/web/* . && rm -rf build
find . -maxdepth 1 ! -name '.git' ! -name 'build' ! -name '.' -exec rm -rf {} + 2>/dev/null || true
cp -r build/web/* . && rm -rf build
git add -A
git commit -m "Deploy updated app to GitHub Pages"