# Hugo Bibliography

Hugo Bibliography is a Hugo Module designed to help you fetch and format bibliography data. This module comes with scripts and shortcodes you can seamlessly integrate into your project to quickly add an in-text citation or Bibliography page to your static site. 

## Features

All of the shortcodes rely on CSL-JSON data in /data/bibliography.json

#### Bibliography

To add a full bibliography, call the bibliography shortcode with the following:

`{{<bibliography>}}`

You can add a parameter to limit the scope of the bibliography.

`{{<bibliography itemType="journalArticle">}}`

The above shortcode will now only render entries of the bibliography that includes a key of "itemType" with the corresponding value of "journalArticle."

An in-text citation can be generated using the cite shortcode and a specific title.

#### Cite

To add an in-text citation, use the cite shortcode and specify the title of the work you want to cite. 

`{{<cite title="Title Of Work">}}`

Finally, you can generate a bibliography of only the works that have been cited on a given page using the following:

`{{<bibliography cited="true">}}`

#### fetch-zotero.sh

fetch-zotero is a script that comes with hugo-bibliography. It allows you to fetch bibliography data from a Zotero group prior to your hugo build. This ensures your bibliography data stays up to date with activity in your zotero group.

For more information on using this script in your project, see Configuration.

#### Zotero detection

By default, hugo-bibliography includes COinS data to its bibliography shortcode. If you're using Zotero Connector, you should be able to save any and all of the bibliography citations into Zotero.

## Installation

To use Hugo-bibliography, simply add the module as a theme in your hugo project.

`git submodule add https://github.com/dh-tech/hugo-bibliography.git themes/hugo-bibliography`

Then add the theme in your hugo.toml file.

`theme = ['hugo-bibliography']`

## Configuration

Hugo-Bibliography comes with shell scripts to fetch bibliography data from common sources, namely Zotero. 

To use the fetch-zotero.sh script in your hugo project, first configure the Group_ID.

In fetch-zotero.sh, change the `GROUP_ID` variable to your group id.

Next, configure the script based on the following use cases.

### Running Hugo Locally:

To use the fetch-zotero script when running the application locally, first make sure you have installed the necessary dependencies. These dependencies are jq and curl. To check if these packages are installed run the following:

`jq --version`

`curl --version`

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
### Deploying your Hugo Site on Github Pages:

If you're deploying your Hugo Site through Github Pages, add in the following commands to your file in /.github/workflows before the build script.

`- name: Install jq for fetch script
        run: sudo apt-get update && sudo apt-get install -y jq
      - name: Run Zotero fetch script
        run: ../../themes/hugo-bibliography/fetch-zotero.sh
`