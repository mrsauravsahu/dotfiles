github_repo(
  name = "pleasings",
  repo = "thought-machine/pleasings",
  revision = "6e554afd40449b5364d47f401bc22382f996733b",
)

sh_cmd(
  name = "pdf",
  cmd = 'docker run --rm -v "\\`pwd\\`:/data" paper:latest bash -c "node app.js \\\$@ \\\$@.out.md; pandoc \\\$@.out.md -o \\\$@.pdf --filter=/data/emoji_filter.js && rm \\\$@.out.md"'
)

gentest(
  name = "app_test",
  test_cmd = "echo add your tests here - for example a spellcheck",
  no_test_output = True
)
