module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App
-- import List
import Dice
import Debug


-- MODEL


-- List.repeat 6 diceModel

type alias BoardModel =
  { diceModel : Dice.Model
  }

initialModel : BoardModel
initialModel =
  { diceModel = Dice.initialModel
  }


init : ( BoardModel, Cmd Msg )
init =
  ( initialModel, Cmd.none )


-- MESSAGES


type Msg
  = DiceMsg Dice.Msg
  | RollDice


-- VIEW


view : BoardModel -> Html Msg
view model =
  div []
    [ Html.App.map DiceMsg (Dice.view model.diceModel)
    , button [ onClick RollDice ] [ text "Roll Dice" ]
    ]


-- UPDATE


update : Msg -> BoardModel -> ( BoardModel, Cmd Msg )
update msg model =
  case msg of
    DiceMsg subMsg ->
      let
          ( updatedDiceModel, diceCmd ) =
            Dice.update (Debug.log "submsg-DiceMsg" subMsg) model.diceModel
      in
          ( { model | diceModel = updatedDiceModel }
          , (Debug.log "none-DiceMsg" Cmd.none) )
    RollDice ->
      let
          ( updatedDiceModel, diceCmd ) =
            Dice.update Dice.Roll model.diceModel
      in
          ( { model | diceModel = updatedDiceModel }
          , Cmd.map (Debug.log "dicemsg-RollDice" DiceMsg) (Debug.log "dicecmd-RollDice" diceCmd) )

-- SUBSCRIPTIONS


subscriptions : BoardModel -> Sub Msg
subscriptions model =
  Sub.none


-- MAIN


main : Program Never
main =
  Html.App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
