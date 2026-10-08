# Table standard

Use this for every new or changed data table. In existing projects, use the project's shared table component and add only what's missing.

## Structure
- A real `<table>` with `<thead>`/`<tbody>`, or the project's table component. No div grids pretending to be tables.
- **Header:**
  - sticky when the table scrolls inside its container
  - sortable columns show their sort state (`aria-sort`)
- **Column widths:**
  - fixed for narrow data (status, dates, amounts, actions)
  - flexible for the main text column
- **Alignment:** text left, numbers and amounts right (with tabular numbers), status and actions centred or right.
- **Long text:** truncate with an ellipsis and show the full value on hover or focus (a `title` attribute or tooltip). Never let a cell break the layout.

## Rows
- **Height** follows the project density (e.g. Dense about 36–40px, Simple about 48–56px).
- **Clickable rows:** the main cell contains a real link or button, so the row is keyboard reachable. Don't put `onClick` on the `<tr>` alone.
- **Row actions:**
  - up to 2 frequent actions as icon buttons with `aria-label`
  - everything else in a "More actions" (⋯) menu
  - destructive actions ask for confirmation

## Selection and bulk actions
- A checkbox column using the custom `Checkbox`.
- The header checkbox selects the current page and shows a mixed state when partly selected.
- When rows are selected, a **bulk action bar** appears above the table: "N selected", the actions, and "Clear".
- Selection clears when filters or the page change, unless the plan says otherwise.

## Paging, sorting, filtering
- Server-side when the data can grow past about 200 rows; client-side for small fixed lists.
- State lives in the URL (page, page size, sort, filters).
- Show the total count ("1–25 of 340").

## States
- **First load:** skeleton rows.
- **Refreshing:** keep the rows visible, with a subtle indicator.
- **Empty:** two kinds:
  - "No data yet" (with the primary action)
  - "No results for these filters" (with "Clear filters")
- **Error:** a message plus Retry inside the table area.

## Mobile (below about 768px)
- **Few columns:** horizontal scroll inside the table container, with the first column sticky.
- **Many columns:** switch to a card list. Show the main field as the title, 2–3 key fields, and the actions menu.
- The page itself never scrolls horizontally.
