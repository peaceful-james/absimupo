#!/bin/zsh

./dev/login-backend-staging.sh

local branch_name=${$(git symbolic-ref --quiet HEAD)#refs/heads/}

echo "DEPLOYING $branch_name branch to absimupo"
sleep 2

git push --force --no-verify gigalixir `git subtree split --prefix absimupo_backend $branch_name`:refs/heads/master

echo ""

echo "IMPORTANT: don't forget to migrate if it's needed (requires the SSH key to have been added)"
echo "gigalixir ps:migrate -a absimupo"

echo "or access the iex shell: gigalixir ps:remote_console -a absimupo"

(paplay /usr/lib/libreoffice/share/gallery/sounds/ok.wav; paplay /usr/lib/libreoffice/share/gallery/sounds/apert.wav) || echo "Feel free to comment out this 'paplay' line. It's just a way to get notified of the deploy finishing."

watch -n 6 gigalixir ps -a absimupo
