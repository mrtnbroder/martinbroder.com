import { assertEvent, assign, createActor, createMachine, setup } from "xstate"

function onComboboxKeyUpEnter(args, params) {
  console.log("args", args)
  console.log("context", context)
  console.log("params", params)
  console.log("onComboboxKeyUpEnter")
}

export const machine = setup({
  types: {
    context: {} as {
      value: string
      filter: string
      focusIndex: number
      open: boolean
    },
    events: {} as
      | { type: "input.focus" }
      | { type: "input.blur" }
      | { type: "input.input"; value: string }
      | { type: "input.keydown" }
      | { type: "input.keyup"; event: KeyboardEvent },
  },
  guards: {
    isBackspace: (_args, params: { event: KeyboardEvent }) => {
      // assertEvent(params.event, "input.keyup")
      return params.event.key === Action.BACKSPACE
    },
  },
  actions: {
    onComboboxBlur: assign({
      open: false,
    }),
    onComboboxFocus: assign({
      open: true,
    }),
    onComboboxInput: assign({
      value: ({ context, event }) => {
        assertEvent(event, "input.input")
        console.log("event", event)
        return event.value
      },
    }),
    onComboboxKeyDown: () => {
      /* ... */
    },
    onComboboxKeyUpEnter,
    onComboboxKeyUpBackspace: (_, params) => {
      console.log("onComboboxKeyUpBackspace")
      console.log("params", params)
      // assertEvent(params.event, "input.keyup")
      // return params.event.key
    },
    onComboboxKeyUp: (_, params) => {
      console.log("onComboboxKeyUp")
      console.log("params", params)
      // assertEvent(params.event, "input.keyup")
      // return params.event.key
    },
    // onComboboxKeyUp: assign({
    //   filter: ({ context, event }) => {
    //     assertEvent(event, "input.keyup")
    //     return context.filter + event.event.key
    //   },
    // }),
    setFilter: (_) => {
      /* ... */
    },
  },
}).createMachine({
  id: "combobox",
  initial: "idle",
  context: {
    value: "",
    filter: "",
    focusIndex: -1,
    open: false,
  },
  states: {
    idle: {
      description: "The combobox is idle.",
      on: {
        "input.focus": {
          target: "focused",
          actions: "onComboboxFocus",
        },
      },
    },
    focused: {
      description: "The combobox is focused.",
      on: {
        "input.blur": {
          description: "The combobox received the blur event.",
          target: "idle",
          actions: "onComboboxBlur",
        },
        "input.input": {
          description: "The combobox received the input event.",
          actions: {
            type: "onComboboxInput",
            // params: ({ event }) => ({ value: event.value }),
          }
        },
        "input.keydown": {
          description: "The combobox received the keydown event.",
          actions: "onComboboxKeyDown",
        },
        "input.keyup": [
          {
            description: "The combobox received the keyup event with Backspace.",
            actions: "onComboboxKeyUpBackspace",
            guard: {
              type: "isBackspace",
              params: ({ event: { event } }) => ({ event }),
            },
          },
          {
            description: "The combobox received the keyup event.",
            actions: "onComboboxKeyUp",
          },
        ],
      },
    },
  },
})

export enum Action {
  BACKSPACE = "Backspace",
  ENTER = "Enter",
  ESCAPE = "Escape",
  SPACE = " ",
  TAB = "Tab",
  ARROW_DOWN = "ArrowDown",
  ARROW_UP = "ArrowUp",
  ARROW_LEFT = "ArrowLeft",
  ARROW_RIGHT = "ArrowRight",
  HOME = "Home",
  END = "End",
  PAGE_UP = "PageUp",
  PAGE_DOWN = "PageDown",
  //
  TYPING = "Typing",
}
