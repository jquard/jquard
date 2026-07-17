// Turbo Drive swaps the <body> on every visit while this module runs only
// once, so the dialog must be looked up at call time — a captured reference
// would go stale (detached node) after the first navigation.
const findDialog = () => document.getElementById("jquard-confirm-dialog")

const confirmWithDialog = (message, formElement) => {
  const dialog = findDialog()
  if (!dialog) return Promise.resolve(window.confirm(message))

  const data = formElement?.dataset ?? {}

  dialog.querySelector("[data-slot=heading]").textContent = data.confirmHeading || "Confirm action"
  dialog.querySelector("[data-slot=description]").textContent = message
  dialog.querySelector("[data-slot=confirm]").textContent = data.confirmButton || "Confirm"

  dialog.returnValue = ""
  dialog.showModal()

  return new Promise((resolve) => {
    dialog.addEventListener("close", () => resolve(dialog.returnValue === "confirm"), { once: true })
  })
}

document.addEventListener("click", (event) => {
  if (event.target instanceof HTMLDialogElement && event.target.id === "jquard-confirm-dialog") {
    event.target.close("")
  }
})

if (window.Turbo) {
  if (window.Turbo.config?.forms) {
    Turbo.config.forms.confirm = confirmWithDialog
  } else {
    Turbo.setConfirmMethod(confirmWithDialog)
  }
}

document.addEventListener("change", (event) => {
  if (event.target.matches("[data-jq-autosubmit]")) event.target.form?.requestSubmit()
})
