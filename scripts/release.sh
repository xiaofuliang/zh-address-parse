set -e
echo "Enter release version: "
read VERSION

read -p "Releasing $VERSION - are you sure? (y/n)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "Releasing $VERSION ..."

  npm run build
  npm run build-lib
  git add .
  git commit -m "$VERSION"
  git push origin develop
  # commit
  npm version $VERSION --message "build: $VERSION"
  git checkout master
  git merge develop
  git push origin master

  # publish
  git tag $VERSION -m "release: $VERSION"
  git push origin "$VERSION"

  git checkout develop
fi
