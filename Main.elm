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


type alias DiceToBeRolled =
    List Bool


initialDiceToBeRolled : List Bool
initialDiceToBeRolled =
    [ True
    , True
    , True
    , True
    , True
    ]



-- Main model


type alias Board =
    { dice : List Die
    , diceToBeRolled : DiceToBeRolled
    }


initialModel : Board
initialModel =
    { dice =
        [ initialDie
        , initialDie
        , initialDie
        , initialDie
        , initialDie
        ]
    , diceToBeRolled = initialDiceToBeRolled
    }


init : ( Board, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- MESSAGES


type Msg
    = Roll
    | OnResult (List Die)
    | SelectDie Die



-- VIEW


renderDie : Int -> Die -> Bool -> Html Msg
renderDie i die willRoll =
    let
        shadow =
            if willRoll then
                ( "background-color", "lightgrey" )
            else
                ( "", "" )

        dieStyle =
            style
                [ ( "padding", "10px" )
                , ( "display", "table-cell" )
                , ( "vertical-align", "middle" )
                , ( "border", "1px solid black" )
                , ( "border-radius", "8px" )
                , ( "height", "45px" )
                , ( "width", "45px" )
                , shadow
                ]
    in
        p [ dieStyle, onClick (SelectDie i) ] [ text (toString die) ]


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
            [ div [ diceStyle ] (List.map3 renderDie [ 0, 1, 2, 3, 4 ] model.dice model.diceToBeRolled)
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
            ( { model | dice = res, diceToBeRolled = initialDiceToBeRolled }, Cmd.none )

        SelectDie msg ->
            let
                diceIndex =
                    (Debug.log "die index" msg)

                newToBeRolled =
                    List.indexedMap
                        (\i willRoll ->
                            if i == diceIndex then
                                not willRoll
                            else
                                willRoll
                        )
                        model.diceToBeRolled
            in
                ( { model | diceToBeRolled = (Debug.log "new list" newToBeRolled) }, Cmd.none )



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
