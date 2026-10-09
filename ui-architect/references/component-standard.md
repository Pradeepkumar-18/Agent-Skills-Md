# Component standard

How every shared component is built or extended. Rules are tagged by priority. Follow the project's existing conventions where they already cover a rule.

## CRITICAL

### C1. One component, many uses: extend, don't copy
❌ Wrong: copy `Button.tsx` to `DangerButton.tsx` and change the colour.
✅ Right: add a `danger` variant to `Button`.

### C2. Theme tokens only
❌ `className="bg-[#2563eb] rounded-[6px] px-[14px]"`
✅ `className="bg-primary rounded-md px-4"` (classes that come from the project's tokens)

### C3. Backward-compatible extension
New props are optional and have defaults, so existing uses keep working. A breaking change needs the user's OK and a list of the affected screens.

## HIGH

### H1. Variants, not boolean piles
❌
```tsx
<Button isPrimary isLarge isOutlined isDanger />
```
✅
```tsx
<Button variant="danger" size="lg" />
// variant: 'primary' | 'secondary' | 'outline' | 'ghost' | 'danger'
// size: 'sm' | 'md' | 'lg'
```
Keep variants few and distinct. No duplicates like `primary`/`solid`.

### H2. Always customisable from outside
Every shared component:
- accepts `className` and merges it last (with the project's class-merge helper, e.g. `cn()`), so callers can adjust layout
- passes the remaining native props through (`...rest`) to the main element
- forwards `ref` when focus or measuring matters (inputs, buttons, dialogs)

```tsx
type ButtonProps = React.ButtonHTMLAttributes<HTMLButtonElement> & {
  variant?: 'primary' | 'secondary' | 'outline' | 'ghost' | 'danger';
  size?: 'sm' | 'md' | 'lg';
  loading?: boolean;
  startIcon?: React.ReactNode;
};
export const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ variant = 'primary', size = 'md', loading, startIcon, className, children, disabled, ...rest }, ref) => (
    <button ref={ref} disabled={disabled || loading}
      className={cn(base, variants[variant], sizes[size], className)} {...rest}>
      {loading ? <Spinner /> : startIcon}{children}
    </button>
  ));
```

### H3. Custom content through children and slots
❌ `<Card title="..." subtitle="..." footerText="..." showFooterButton />`
✅ Compound parts or slots:
```tsx
<Card>
  <Card.Header title="Orders" actions={<Button size="sm">Export</Button>} />
  <Card.Body>{...}</Card.Body>
  <Card.Footer>{...}</Card.Footer>
</Card>
```
Use compound components (`Table.Header`, `Table.Row`…) for complex components. Use simple slot props (`actions`, `icon`, `footer`) for small ones.

### H4. Accessible by default
- Correct element and roles.
- Keyboard support.
- A label on every input and icon button.
- Visible focus.
- Dialogs trap focus, close on Esc and return focus.
- Actions are visible, never hover-only.

### H5. Form controls are custom and complete
Custom controls (no browser defaults in projects without a UI library) support:
- `label`, `hint`, `error`, `disabled` and `required`
- controlled use (`value` + `onChange`)
- the matching limits: `min`/`max` for number and date, `minDate`/`maxDate`/`disabledDates` for date pickers, `accept`/`maxSize` for file upload

Checkbox, radio and switch keep the native input visually hidden underneath.

## MEDIUM

### M1. Sensible defaults
The common case needs no props: `<Button>Save</Button>` works.

### M2. One job per component, about 200 lines or fewer
Split big components into sub-components or hooks.

### M3. State stays where it belongs
- Shared UI components hold UI state only (open, focus, hover).
- They never fetch data. Data goes in through props.

### M4. Location and export
Put the component in the shared folder (see `project-structure.md`) and export it from the folder's index file, if the project uses one.

### M5. Record it
Add or update its entry in `docs/components.md` (name, purpose, props, variants, example). If that file was declined, list it in the hand-over.

## Checklist before creating a shared component (show this at the checkpoint)

- Name and location
- Props (with types and defaults) and variants
- Slots or compound parts
- Which existing copies it replaces
- Example usage
