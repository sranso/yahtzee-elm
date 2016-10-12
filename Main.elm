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
  | OnResult (List Die)


-- VIEW


renderDie : Die -> Html Msg
renderDie die =
  let
    dieStyle =
      style
        [ ( "padding", "10px" )
        , ( "display", "table-cell" )
        , ( "vertical-align", "middle" )
        , ( "border", "1px solid black" )
        , ( "border-radius", "8px" )
        , ( "height", "45px" )
        , ( "width", "45px" )
        ]
  in
    p [ dieStyle ] [ text (toString die) ]


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
    diceStyle =
      style
        [ ( "display", "table" )
        , ( "margin", "20px auto" )
        , ( "border-spacing", "20px" )
        ]
    buttonStyle =
      style
        [ ( "padding", "10px" )
        ]
  in
    div [ divStyle ]
      [ div [ diceStyle ] ( List.map (\die -> renderDie die) model.dice )
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
