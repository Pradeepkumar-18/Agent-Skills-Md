# Flow: Reference image (screenshot, mock-up, Figma export)

Use this when the user attaches an image, or points to one, as **the design to build**.

If the user says "fix" with an image, read the section `"Fix this" with an image` in `flows/bug-fix.md` first.

1. **Read it and write back what you see:** layout and sizes, sections and grouping, item anatomy, active/selected style, icon style, typography, spacing, radius, colours. → *Checkpoint: "Is this right?"*
2. **List what the image can't show,** with a recommendation for each: hover/focus states, collapsed or empty states, mobile layout, dark mode, behaviour (what clicks do, what badges count).
3. **Map the image to the project; don't copy it pixel for pixel:**
   - **Colours:** Existing mode maps them to the nearest existing tokens. If they differ a lot, ask "match exactly (new tokens) or adapt to your theme?" and recommend adapting. In New mode, the image may seed the theme if the user wants.
   - **Icons:** redraw them with the project's icon set.
   - **Spacing and size:** follow the project's density (New mode: the image may set it).
   - **Logos, brand names and product content from other companies:** never copy them. Take the layout and style only.
4. **Plan:** run `flows/feature.md`, but skip its step 1 (the "what I see" checkpoint replaces it), and fill the plan's "Reference → implementation" section with each element, how it's built, and any intentional differences.
5. **After building, compare:** if the tool can take a screenshot, compare it side by side with the reference and fix the differences. Otherwise check the result against the spec from step 1.
