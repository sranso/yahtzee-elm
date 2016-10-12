module Die exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App
import Random


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
      ( model, Random.generate OnResult ( Random.int 1 6 ) )
    OnResult res ->
      ( res, Cmd.none )

