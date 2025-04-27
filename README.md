# Blackhole Search

A bash script to help me be more deliberate with my search queries. This is intended to be used with RayCast, but can be used in your terminal.

## what

There are some topics I can search for endlessly, trying to get a ton of information, but never having enough.

This is the antidote - it helps you define "enough".

This script creates a note in Obsidian with a pre-defined template, prompting you to fill out what you actually want to get out of the search.
Your search won't start until you're ready, giving you time to think about what you're really doing.

Simply type `y` next to `**Ready to Search**: ` and you're off to the races.

https://github.com/user-attachments/assets/0c09ee8c-8eab-4788-bd5a-57691d3f1883

## setup

Be sure to set the following environment variables.

```bash
export OBSIDIAN_VAULT_NAME="your_vault_name"
export OBSIDIAN_VAULT_PATH="your_vault_path"
export BLACKHOLE_SEARCH_URL="https://www.perplexity.ai/search?q=
```

## future ideas

- execute timer when planned time is up
- pass a command rather than a url
