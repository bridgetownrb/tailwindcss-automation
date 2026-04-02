# tailwindcss-automation

An automation for installing [TailwindCSS](https://tailwindcss.com) in a [Bridgetown](https://www.bridgetownrb.com) site.

In your Bridgetown project folder, run:

```
bin/bridgetown apply https://github.com/bridgetownrb/tailwindcss-automation
```

You can also apply the automation when creating a new site:

```
bridgetown new mysite --apply=https://github.com/bridgetownrb/tailwindcss-automation
```

The automation will install `tailwindcss` and `@tailwindcss/cli`, create `frontend/styles/tailwind.css` with the recommended `@import` and `@source` directives, wire Tailwind into your frontend bundling manifest, and add a `bin/tailwindcss` helper for building and watching.

During `frontend:build`, the `bin/tailwindcss` helper runs the Tailwind CLI, then fingerprints the generated CSS and updates the Bridgetown manifest entry for `styles/tailwind.css`. During `frontend:watch`, the helper runs Tailwind in watch mode.

To load the stylesheet in your templates, add a link tag to your head partial (likely `src/_partials/_head.erb`):

```
<link rel="stylesheet" href="<%= asset_path "styles/tailwind.css" %>" />
```

Any questions? [Check out the Bridgetown community discussion channels for help.](https://www.bridgetownrb.com/community)

----

## Future Compatibility Message

The Tailwind automation used to be a configuration option bundled with Bridgetown, but it has since been extracted to this community-maintained repository. I ([@jaredcwhite](https://github.com/jaredcwhite)) do not use or endorse Tailwind, but I'm happy to accept PRs to keep the automation working in case a future version of Tailwind breaks the script in some way. Thanks!
