# flutter_widget_keys_demo

A Flutter demo of widget keys. Each screen shows the same widget twice: once without a key, and once with a key, so you can see which `State` Flutter keeps.

Open the app and pick a key from the menu.

| Screen | Key | What you see |
|---|---|---|
| `ValueKey` | `ValueKey(id)` | Two drag-to-reorder lists. Without a key on the item, the rating stays at that position. With `ValueKey`, the rating follows the card. |
| `UniqueKey` | `UniqueKey()` | One counter and a Reset button. Without a key, Reset only calls `setState` and the count stays. With a new `UniqueKey`, Flutter creates a new `State` and the count goes back to 0. |
| `ObjectKey` | `ObjectKey(item)` | Two drag-to-reorder lists, same as `ValueKey`, but the key is the item object. Without `ObjectKey`, the rating stays at that position. With `ObjectKey`, the rating follows that object. |
| `GlobalKey` | `GlobalKey<DemoChildFormState>` | A parent Validate button and a child form. Without a key, the parent cannot call the child's `validate()`. With a `GlobalKey`, it calls `formKey.currentState?.validate()`. |

## Run

```bash
flutter run
```
