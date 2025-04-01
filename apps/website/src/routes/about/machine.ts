import {
  assertEvent,
  assign,
  createActor,
  createMachine,
  enqueueActions,
  log,
  setup,
  type ActionFunction,
} from "xstate"

interface ComboboxContext {
  value: string
  filter: string
  options: Array<{ value: string; label: string }>
  focusIndex: number
  open: boolean
}

type ComboboxEvents =
  | { type: "input.focus" }
  | { type: "input.blur" }
  | { type: "input.input"; value: string }
  | { type: "input.mousedown"; event: MouseEvent }
  | { type: "input.keydown"; event: KeyboardEvent }
  | { type: "input.keyup"; event: KeyboardEvent }
  | { type: "option.select"; event: Event }

export const machine = setup({
  types: {
    context: {} as ComboboxContext,
    events: {} as ComboboxEvents,
  },
  guards: {},
  actions: {
    onComboboxBlur: assign({
      open: false,
    }),
    onComboboxFocus: assign({
      open: true,
    }),
    onComboboxInput: assign({
      value: ({ event }) => {
        assertEvent(event, "input.input")
        // console.log("event", event, event.value)
        return event.value
      },
    }),
    onComboboxKeyDown: ({ event }) => {
      assertEvent(event, "input.keydown")
      console.log("onComboboxKeyDown")
      console.log("event", event)
      // console.log("params", params)
    },
    onComboboxKeyUpEnter: ({ event }) => {
      assertEvent(event, "input.keyup")
      console.log("onComboboxKeyUpEnter")
      console.log("event", event)
      // console.log("params", params)
    },
    onComboboxKeyUpBackspace: ({ event }) => {
      assertEvent(event, "input.keyup")
      console.log("onComboboxKeyUpBackspace")
      console.log("event", event)
      // console.log("params", params)
      // assertEvent(params.event, "input.keyup")
      // return params.event.key
    },
    onComboboxKeyUp: ({ event }) => {
      assertEvent(event, "input.keyup")
      console.log("onComboboxKeyUp")
      console.log("event", event)
      // console.log("params", params)
      // assertEvent(params.event, "input.keyup")
      // return params.event.key
    },
    onOptionSelect: ({ event }) => {
      assertEvent(event, "option.select")
      console.log("onOptionSelect")
      console.log("event", event)
      // console.log("params", params)
    },
  },
}).createMachine({
  /** @xstate-layout N4IgpgJg5mDOIC5QGMD2BbARq7APAdAJYQA2YAxIQHYAOArgC74BmqydsA2gAwC6ioGqliEGhVFQEhciAEyyArPgUBmAIyyALJoCcADjUruahZoA0IAJ6JNANlv5bK2Xv0B2LTpUqFAX18WaFg4qASs7LCQlLSM+JgkdABOPPxIIEIiYhJSMgjySqoa2vqGxqYW1gjeeo5uOm56mtyydW5qav6BGNh4LGwcUdT0TEOMKVIZouKSabmqmviyOrZ6bgpqegrGam4ViN5u+E22Szqytpp6Rh0BIEE9oX0RgzFMANZglhCoAO5U42lJlkZqA5vJ8OpFNw7Lo3JC9nluDojoVZCpNG43PZYZ07t0QmF+pEINFhvgPpY6DQAYJhFNsrNEIUIVo1DpVG1NGpbAoEQZlNxBdxVnpuG5mgpbP5blRUBA4FJ7gSJnTgTlEABaWwIrW4pW9YhkFWZabqhCaWQIzQKWQQhQ6bRqaHrS56PX43rhAYQY30kHSJlXCHQnlYuotPRW8V2h1rbjrHTszTS3xAA */
  id: "combobox",
  initial: "idle",
  context: {
    value: "",
    filter: "",
    focusIndex: -1,
    options: [],
    open: false,
  },
  states: {
    idle: {
      description: "The combobox is idle.",
      on: {
        "input.focus": {
          target: "focused",
          actions: { type: "onComboboxFocus" },
        },
      },
    },
    focused: {
      description: "The combobox is focused.",
      on: {
        "option.select": {
          description: "The user selected an option.",
          actions: { type: "onOptionSelect" },
        },
        "input.blur": {
          description: "The combobox received the blur event.",
          target: "idle",
          actions: { type: "onComboboxBlur" },
        },
        "input.input": {
          description: "The combobox received the input event.",
          actions: { type: "onComboboxInput" },
        },
        "input.keydown": {
          description: "The combobox received the keydown event.",
          actions: { type: "onComboboxKeyDown" },
        },
        "input.keyup": {
          description: "The combobox received the keyup event.",
          actions: enqueueActions(({ enqueue, event }) => {
            log("event", event.event.key)
            switch (event.event.key) {
              case KEY_CODES.ENTER:
                enqueue({ type: "onComboboxKeyUp", "params": { event: event.event } });
              case KEY_CODES.BACKSPACE:
                enqueue("onComboboxKeyUpBackspace");
                break;
              default:
                enqueue("onComboboxKeyUp");
            }
          }),
        },
      },
    },
  },
})

export enum COMBOBOX_ACTIONS {
  SELECT_OPTION = "SELECT_OPTION",
  CLOSE = "CLOSE",
  OPEN = "OPEN",
  SELECT_FST_OPTION = "SELECT_FST_OPTION",
  SELECT_LST_OPTION = "SELECT_LST_OPTION",
  SELECT_NEXT_OPTION = "SELECT_NEXT_OPTION",
  SELECT_PREV_OPTION = "SELECT_PREV_OPTION",
  CLEAR = "CLEAR",
  TYPING = "TYPING",
}

export enum KEY_CODES {
  BACKSPACE = "Backspace",
  DELETE = "Delete",
  ENTER = "Enter",
  ESCAPE = "Escape",
  CLEAR = "Clear",
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
}

function isBackspace(event: KeyboardEvent) {
  return event.key === KEY_CODES.BACKSPACE
}

function isEnter(event: KeyboardEvent) {
  return event.key === KEY_CODES.ENTER
}

function isArrowDown(event: KeyboardEvent) {
  return event.key === KEY_CODES.ARROW_DOWN
}

function isArrowUp(event: KeyboardEvent) {
  return event.key === KEY_CODES.ARROW_UP
}

function isArrowLeft(event: KeyboardEvent) {
  return event.key === KEY_CODES.ARROW_LEFT
}

function isArrowRight(event: KeyboardEvent) {
  return event.key === KEY_CODES.ARROW_RIGHT
}

function isHome(event: KeyboardEvent) {
  return event.key === KEY_CODES.HOME
}

function isEnd(event: KeyboardEvent) {
  return event.key === KEY_CODES.END
}

function isPageUp(event: KeyboardEvent) {
  return event.key === KEY_CODES.PAGE_UP
}

function isPageDown(event: KeyboardEvent) {
  return event.key === KEY_CODES.PAGE_DOWN
}

function isTab(event: KeyboardEvent) {
  return event.key === KEY_CODES.TAB
}

function isEscape(event: KeyboardEvent) {
  return event.key === KEY_CODES.ESCAPE
}

function isDelete(event: KeyboardEvent) {
  return event.key === KEY_CODES.DELETE
}

function isClear(event: KeyboardEvent) {
  return event.key === KEY_CODES.CLEAR
}

function isSpace(event: KeyboardEvent) {
  return event.key === KEY_CODES.SPACE
}

function isPrintableCharacter(event: KeyboardEvent) {
  return event.key.length === 1 && !!event.key.match(/\S| /)
}
