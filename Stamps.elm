module Stamps exposing (..)

import Element exposing (..)
import Html exposing (..)
import Mouse
import Svg exposing (..)
import Svg.Attributes exposing (..)
import VirtualDom


type alias Position =
    ( Int, Int )


type alias Model =
    { clicks : List Position
    }


type Msg
    = AddClick Position


model : Model
model =
    { clicks = clicks
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddClick pos ->
            { model | clicks = pos :: model.clicks } ! []



-- drawStamp takes a position and return a graphics svg


drawStamp : ( Int, Int ) -> Svg msg
drawStamp ( x, y ) =
    let
        string_x =
            toString (x)

        string_y =
            toString (y)
    in
        Svg.circle
            [ fill "#60B5CC", fillOpacity "0.5", cx string_x, cy string_y, r "10" ]
            []


view : Model -> Html Msg
view model =
    let
        group =
            List.map drawStamp model.clicks
    in
        -- Now make a collage containing the group
        svg
            [ Svg.Attributes.width "300", Svg.Attributes.height "300", viewBox "0 0 300 300" ]
            group


clicks : List ( Int, Int )
clicks =
    -- We'll just init positions
    []


main : Program Never Model Msg
main =
    Html.program
        { init = ( model, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Mouse.clicks (\{ x, y } -> AddClick ( x, y ))
