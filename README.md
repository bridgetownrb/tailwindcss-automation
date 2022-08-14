# tailwindcss-automation

An automation for installing [TailwindCSS](https://tailwindcss.com) in a [Bridgetown](https://www.bridgetownrb.com) site.

In your Bridgetown project folder, run:

```
bin/bridgetown apply https://github.com/bridgetownrb/tailwindcss-automation
```

(Note: it will overwrite any existing `postcss.config.js` file in your repo.)

You can also apply the automation when creating a new site:

```
bridgetown new mysite --apply=https://github.com/bridgetownrb/tailwindcss-automation
```

The automation will add Tailwind to your `package.json`, set up a default Tailwind config, add the import statements to your frontend CSS entrypoint, and add a builder which will detect when content in `src` is modified and trigger Tailwind's JIT compiler to run.

Any questions? [Check out the Bridgetown community discussion channels for help.](https://www.bridgetownrb.com/community)

----

## Future Compatibility Message

The Tailwind automation used to be a configuration option bundled with Bridgetown, but it has since been extracted to this community-maintained repository. I ([@jaredcwhite](https://github.com/jaredcwhite)) do not use or endorse Tailwind, but I'm happy to accept PRs to keep the automation working in case future version of Tailwind breaks the script in some way. Thanks!
