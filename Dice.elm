module Dice exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App
import Random
import Debug


-- MODEL


type alias Model =
  Int


initialModel : Model
initialModel =
  1


init : ( Model, Cmd Msg )
init =
  ( initialModel, Cmd.none )

-- MESSAGES


type Msg
  = Roll
  | OnResult Int


-- VIEW


view : Model -> Html Msg
view model =
  div []
      [ text (toString model)
      ]


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Roll ->
      ( model, (Debug.log "random-Roll" Random.generate OnResult ( Random.int 1 6 )) )
    OnResult res ->
      ( res, (Debug.log "none-OnResult" Cmd.none) )


-- MAIN


main : Program Never
main =
  Html.App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = (always Sub.none)
    }
