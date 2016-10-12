module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App
import List
import Random


-- MODEL


type alias Board =
  { die : Die
  }

initialModel : Board
initialModel =
  { die = initialDie
  }


type alias Die =
  Int

initialDie : Die
initialDie =
    1


init : ( Board, Cmd Msg )
init =
  ( initialModel, Cmd.none )


-- MESSAGES


type Msg
  = Roll
  | OnResult Int


-- VIEW


view : Board -> Html Msg
view model =
  div []
    [ text (toString model.die)
    , button [ onClick Roll ] [ text "Roll die" ]
    ]


-- UPDATE


update : Msg -> Board -> ( Board, Cmd Msg )
update msg model =
  case msg of
    Roll ->
      ( model, Random.generate OnResult ( Random.int 1 6 ) )
    OnResult res ->
      ( { model | die = res }, Cmd.none )


-- SUBSCRIPTIONS


subscriptions : Board -> Sub Msg
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
