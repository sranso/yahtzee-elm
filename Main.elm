module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App
import Dice


-- MODEL


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


-- VIEW


view : BoardModel -> Html Msg
view model =
  div []
    [ Html.App.map DiceMsg (Dice.view model.diceModel)
    ]


-- UPDATE


update : Msg -> BoardModel -> ( BoardModel, Cmd Msg )
update msg model =
  case msg of
    DiceMsg subMsg ->
      let
          ( updatedDiceModel, diceCmd ) =
            Dice.update subMsg model.diceModel
      in
          ( { model | diceModel = updatedDiceModel }
          , Cmd.map DiceMsg diceCmd )

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
