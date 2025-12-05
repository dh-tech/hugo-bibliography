# Hugo Bibliography

Hugo Bibliography is a Hugo Module designed to help you fetch and format bibliography data. This module comes with scripts and shortcodes you can seamlessly integrate into your project to quickly add an in-text citation or Bibliography page to your static site. 

## Adding a Bibliography

By default, hugo-bibliography fetches bibliography data from a Zotero group. The fetching of bibliography data is now handled entirely within the hugo build process.

To fetch bibliography data from a Zotero group, you will need to configure your Zotero Group ID inside of your hugo's hugo.toml/hugo.yaml file.

Here is an example of how to configure your Zotero Group ID in a toml file:

`
params = { groupId = 1196 }
`


## Features

All of the shortcodes rely on data fetched from Zotero based on the Zotero Group ID configured in your hugo.toml/hugo.yaml file.

#### Bibliography

To add a full bibliography, call the bibliography shortcode with the following:

`{{<bibliography>}}`

#### Filtering

You can add a parameter to limit the scope of the bibliography.

`{{<bibliography itemType="journalArticle">}}`

The above shortcode will now only render entries of the bibliography that includes a key of "itemType" with the corresponding value of "journalArticle."

The value does not have to be an exact match to the key so long as the value is a substring of the key.

This filtering also works to specify specific collections or subcollections to generate a bibliography for.

#### Taxonomy/Tags

With the current version of hugo-bibliography, you can rig together a taxonomy by making markdown files which dsiplay the bibliography for a specific tag.

`
/content/bibliography/tag-1.md
/content/bibliography/tag-2.md
/content/bibliography/tag-3.md
`

Then, you can add a shortcode to your markdown files to display the bibliography for a specific tag.

`
---
title: "Bibliography for Tag 1"
tags: ["tag-1"]
---

  {{<bibliography keyword="tag-1">}}
`

Using the keyword parameter, you can filter the bibliography to only include entries that have a keyword that matches the tag.

A solution to automatically generating tags for a bibliography without having to make every markdown file manually is in the works.

#### Cite

To add an in-text citation, use the cite shortcode and specify the title of the work you want to cite. 

`{{<cite title="Title Of Work">}}`

Finally, you can generate a bibliography of only the works that have been cited on a given page using the following:

`{{<bibliography cited="true">}}`


#### Zotero detection

By default, hugo-bibliography includes COinS data to its bibliography shortcode. If you're using Zotero Connector, you should be able to save any and all of the bibliography citations into Zotero.

## Installation

To use Hugo-bibliography, simply add the module as a theme in your hugo project.

`git submodule add https://github.com/dh-tech/hugo-bibliography.git themes/hugo-bibliography`

Then add the theme in your hugo.toml file.

`theme = ['hugo-bibliography']`

## Customization

Hugo-Bibliography can be customized in a few ways. The styling for the bibliography shortcode is contained within the bibliography shortcode's html file or /themes/hugo-bibliography/layouts/shortcodes/bibliography.html.

You will notice the styling used for the apa-citation is contained at the top of the file. If you would like to change the bibliography's style (eg. type-face, font-size, padding) you can add your own style rules here. Note that the italics is done through i tags instead of style rules.

