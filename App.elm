module App exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class, style)
import Html.App
import Mouse
import Keyboard


-- MODEL


type Last
    = Press
    | Click
    | None


type alias Model =
    { count : Int
    , position : Mouse.Position
    , keyCode : Keyboard.KeyCode
    , last : Last
    }


initialModel : Model
initialModel =
    Model 0 (Mouse.Position 0 0) 0 None


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- MESSAGES


type Msg
    = MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode



-- VIEW


status : Model -> Html Msg
status model =
    case model.last of
        Click ->
            text "added 1 for a mouse click"

        Press ->
            text "added 2 for a key press"

        None ->
            text "click the mouse or press a key to start"


view : Model -> Html Msg
view model =
    div [ class "container", style [ ( "margin-top", "50px" ) ] ]
        [ div [ class "row" ]
            [ div [ class "twelve columns" ]
                [ Html.h1 [] [ text "Elm Counter" ]
                , Html.h4 [] [ status model ]
                , div [] [ text "count: ", text (toString model.count) ]
                , div [] [ text "last mouse click: ", text (toString model.position) ]
                , div [] [ text "last keyboard press: ", text (toString model.keyCode) ]
                ]
            ]
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMsg pos ->
            ( { model | count = model.count + 1, position = pos, last = Click }, Cmd.none )

        KeyMsg code ->
            ( { model | count = model.count + 2, keyCode = code, last = Press }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.clicks MouseMsg
        , Keyboard.presses KeyMsg
        ]



-- MAIN


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
