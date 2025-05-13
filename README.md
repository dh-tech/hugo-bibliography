# Hugo Bibliography

## Features

## Installation

## Configuration

Hugo-Bibliography comes with shell scripts to fetch bibliography data from common sources, namely Zotero. You can use the fetch-zotero.sh file in your hugo project through the following:

Running Hugo Locally:

To use the fetch-zotero script when running the application locally, first make sure you have installed the necessary dependencies. These dependencies are jq and curl. To check if these packages are installed run the following:

jq --version

curl --version

If you have both of these dependencies installed, run the following to start hugo locally. The fetch script will run first and the hugo-build will include the appropriate data file.

`./themes/hugo-bibliography/fetch-zotero.sh && hugo server`

### Running Hugo Locally through Docker:

If you're using Docker, first install the script's dependencies in the command section of your docker-compose file or Dockerfile. Next, run the fetch script, and finally build the hugo site.

If you're using a docker-compose file, the command should look like the following:

`command: >
      sh -c "
        apk add --no-cache curl jq &&
        ./themes/hugo-bibliography/fetch-zotero.sh &&
        hugo server --bind 0.0.0.0 --port 1313
      "
`
Deploying your Hugo Site on Github Pages:

### If you're deploying your Hugo Site through Github Pages, add in the following commands to your file in /.github/workflows before the build script.

`- name: Install jq for fetch script
        run: sudo apt-get update && sudo apt-get install -y jq
      - name: Run Zotero fetch script
        run: ../../themes/hugo-bibliography/fetch-zotero.sh
`