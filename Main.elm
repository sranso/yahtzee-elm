module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App
-- import List
import Die


-- MODEL


type alias BoardModel =
  { dieModel : Die.Model
  }

initialModel : BoardModel
initialModel =
  { dieModel = Die.initialModel
  }


init : ( BoardModel, Cmd Msg )
init =
  ( initialModel, Cmd.none )


-- MESSAGES


type Msg
  = DieMsg Die.Msg
  | RollDie


-- VIEW


view : BoardModel -> Html Msg
view model =
  div []
    [ Html.App.map DieMsg (Die.view model.dieModel)
    , button [ onClick RollDie ] [ text "Roll die" ]
    ]


-- UPDATE


update : Msg -> BoardModel -> ( BoardModel, Cmd Msg )
update msg model =
  case msg of
    DieMsg subMsg ->
      let
          ( updatedDieModel, dieCmd ) =
            Die.update subMsg model.dieModel
      in
          ( { model | dieModel = updatedDieModel }
          , Cmd.map DieMsg dieCmd )
    RollDie ->
      let
          ( updatedDieModel, dieCmd ) =
            Die.update Die.Roll model.dieModel
      in
          ( { model | dieModel = updatedDieModel }
          , Cmd.map DieMsg dieCmd )

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
