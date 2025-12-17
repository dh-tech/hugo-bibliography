# Hugo Bibliography

Hugo Bibliography is a Hugo Module designed to help you fetch and format bibliography data. This module comes with scripts and shortcodes you can seamlessly integrate into your project to quickly add an in-text citation or Bibliography page to your static site. 

## Adding a Bibliography

Hugo-Bibliography takes bibliography data located in your hugo project's /data/bibliography.json file and generates the in-text citation or bibliography based on this data. This data should be in the CSL-JSON format and there are a few ways to populate this file.

If you use Zotero and already have bibliography data in an existing Zotero group, see the Configuration section on how to configure the fetch-zotero script to automatically populate your bibliography.json file.

If you would like to populate your bibliography.json file manually here's the format you should follow:

- In your bibliography.json file, create a list using square brackets []
- Inside of these square brackets, add entries of JSON data for each citation you would like to make.
- The recommended attributes for each JSON entry (i.e. what hugo-bibliography looks for) includes the following
    - key
    - title
    - list of creators
    - publicationTitle (the journal in which it was published if applicable)
    - volume
    - issue
    - pages
    - date
    - doi

## Features

All of the shortcodes rely on CSL-JSON data in /data/bibliography.json

#### Bibliography

To add a full bibliography, call the bibliography shortcode with the following:

`{{<bibliography>}}`

#### Filtering

You can add a parameter to limit the scope of the bibliography.

`{{<bibliography itemType="journalArticle">}}`

The above shortcode will now only render entries of the bibliography that includes a key of "itemType" with the corresponding value of "journalArticle."

The value does not have to be an exact match to the key so long as the value is a substring of the key.

This filtering also works to specify specific collections or subcollections to generate a bibliography for.

If instead of filtering by a specific key-value pair, you would like to filter by a value that exists anywhere in an entry, you can use the following syntax:

`{{<bibliography keyword="some keyword">}}`

Now, the bibliography will only include entries that have the keyword "some keyword" in any of the values of the entry. This property is particularly useful for generating bibliographies for particular authors, editors or projects.

#### Cite

To add an in-text citation, use the cite shortcode and specify the title of the work you want to cite. 

`{{<cite title="Title Of Work">}}`

Finally, you can generate a bibliography of only the works that have been cited on a given page using the following:

`{{<bibliography cited="true">}}`

#### fetch-zotero.sh

fetch-zotero is a script that comes with hugo-bibliography. It allows you to fetch bibliography data from a Zotero group prior to your hugo build. This ensures your bibliography data stays up to date with activity in your zotero group.

As part of fetch-zotero, the script also fetches data about the collections in your Zotero group. This allows the bibliography shortcode to display the collections that a given work is in as well as display any and all subcollections.

This collections data will be stored directly in a /data/collections-flat.json file. This file will then be processed into more of a tree structure and stored in /data/collections.json which is used by the bibliography shortcode.

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

To use the fetch-zotero.sh script in your hugo project, configure your Zotero Group ID using the `ZOTERO_GROUP_ID` environment variable:

`ZOTERO_GROUP_ID="your-group-id" ./themes/hugo-bibliography/fetch-zotero.sh`

Next, configure the script based on the following use cases.

### Running Hugo Locally:

To use the fetch-zotero script when running the application locally, first make sure you have installed the necessary dependencies. These dependencies are jq and curl. To check if these packages are installed run the following:

`jq --version`

`curl --version`

If you have both of these dependencies installed, run the following to start hugo locally. The fetch script will run first and the hugo-build will include the appropriate data file.

`ZOTERO_GROUP_ID="your-group-id" ./themes/hugo-bibliography/fetch-zotero.sh && hugo server`

### Running Hugo Locally through Docker:

If you're using Docker, first install the script's dependencies in the command section of your docker-compose file or Dockerfile. Next, run the fetch script, and finally build the hugo site.

If you're using a docker-compose file, the command should look like the following:

`command: >
      sh -c "
        apk add --no-cache curl jq &&
        ZOTERO_GROUP_ID=\"your-group-id\" ./themes/hugo-bibliography/fetch-zotero.sh &&
        hugo server --bind 0.0.0.0 --port 1313
      "
`
### Deploying your Hugo Site on Github Pages:

If you're deploying your Hugo Site through Github Pages, add in the following commands to your file in /.github/workflows before the build script.

`- name: Install jq for fetch script
        run: sudo apt-get update && sudo apt-get install -y jq
      - name: Run Zotero fetch script
        run: ZOTERO_GROUP_ID="your-group-id" ../../themes/hugo-bibliography/fetch-zotero.sh
`

## Customization

Hugo-Bibliography can be customized in a few ways. The styling for the bibliography shortcode is contained within the bibliography shortcode's html file or /themes/hugo-bibliography/layouts/shortcodes/bibliography.html.

You will notice the styling used for the apa-citation is contained at the top of the file. If you would like to change the bibliography's style (eg. type-face, font-size, padding) you can add your own style rules here. Note that the italics is done through i tags instead of style rules.

