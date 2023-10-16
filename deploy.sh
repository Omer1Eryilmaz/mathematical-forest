#!/opt/homebrew/bin/fish

## Change directory.
echo -n "Changing directory into `~/Code/ayberkt.github.io`... "
pushd ~/Code/ayberkt.github.io; and echo " OK"; or exit 1
echo "Current working directory is `$(pwd)`"

## Pull from remote.
echo -n "Pulling from remote..."
git pull; and echo " OK"; or exit 1

## Remove the old forest.
echo -n "Removing `mathematical-forest`..."
rm -rf mathematical-forest; and echo " OK"; or exit 1

## Copy the new forest.
echo -n "Copying the last generated forest..."
cp -r ~/Code/mathematical-forest/output mathematical-forest; and echo " OK"; or exit 1

## Verify that files are the same.
if diff -r mathematical-forest ~/Code/mathematical-forest/output
    echo "Successfully copied the forest."
else
    echo "Something went wrong! Two copies are not the same." && exit 1
end

## Commit to git.
echo -n "Adding to git..."
git add mathematical-forest; echo " OK"; or exit 1
echo -n "Committing... "
git commit -m "Update forest [$(date "+%Y-%m-%dT%H:%M:%S")]"; and echo " OK"; or exit 1

## Push.
echo "Running `git push`"
git push

popd
