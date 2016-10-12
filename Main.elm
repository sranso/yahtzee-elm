module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Html.App
import List
import Random


-- MODEL


type alias Die =
  Int

initialDie : Die
initialDie =
    1


-- Main model
type alias Board =
  { dice : List Die
  }

initialModel : Board
initialModel =
  { dice = [ initialDie
           , initialDie
           , initialDie
           , initialDie
           , initialDie
           ]
  }


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
  let
    divStyle =
      style
        [ ( "font-size", "18px" )
        , ( "width", "580px" )
        , ( "margin", "0 auto" )
        , ( "text-align", "center" )
        ]
    dieStyle =
      style
        [ ( "padding", "10px" )
        ]
    buttonStyle =
      style
        [ ( "padding", "10px" )
        ]
  in
    div [ divStyle ]
      [ p [ dieStyle ] [ text (toString model.dice) ]
      , button [ buttonStyle, onClick Roll ] [ text "Roll die" ]
      ]


-- UPDATE

intList : Random.Generator (List Int)
intList =
    Random.list 5 (Random.int 1 6)

update : Msg -> Board -> ( Board, Cmd Msg )
update msg model =
  case msg of
    Roll ->
      -- ( model, Random.generate OnResult ( (Random.int 1 6) ) )
      -- ( model, Random.generate OnResult ( Random.list 5 (Random.int 1 6) ) )
      ( model, Random.generate OnResult intList )
    OnResult res ->
      ( { model | dice = res }, Cmd.none )


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
