module Stamps exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode exposing (Decoder)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)


type alias Model =
    {}


type Msg
    = NoOp
    | Clicking ( Int, Int )


model : Model
model =
    {}


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Clicking cs ->
            let
                _ =
                    Debug.log "coords" cs
            in
                ( model, Cmd.none )


coordsDecoder : Decoder ( Int, Int )
coordsDecoder =
    Decode.field "target" <|
        Decode.map2 (,)
            (Decode.field "offsetLeft" Decode.int)
            (Decode.field "offsetTop" Decode.int)


view : Model -> Html Msg
view model =
    div
        [ Html.Attributes.style
            [ ( "backgroundColor", "blue" )
            , ( "height", "300px" )
            , ( "width", "300px" )
            , ( "position", "relative" )
            , ( "left", "100px" )
            , ( "top", "50px" )
            ]
        , Html.Attributes.class
            "parent"
        , Html.Events.on "click" (Decode.map Clicking coordsDecoder)
        ]
        [ svg
            [ Svg.Attributes.width "100"
            , Svg.Attributes.height "100"
            , Svg.Attributes.style "background: green"
            , viewBox "0 0 100 100"
            , Svg.Events.on "click" (Decode.map Clicking coordsDecoder)
            ]
            []
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
