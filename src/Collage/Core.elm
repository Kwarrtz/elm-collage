module Collage.Core
    exposing
        ( Point
        , Collage
        , BasicCollage(..)
        , Path(..)
        , Shape(..)
        , TextAnchor(..)
        , FillStyle(..)
        , LineStyle
        , LineCap(..)
        , LineJoin(..)
        )

{-| This module contains internal types used accross multiple modules in this packages.
Constructors are however not exposed to the user.
-}

import Html exposing (Html)
import Color exposing (Color)
import Text exposing (Text)
import Json.Decode as Json


type alias Point =
    ( Float, Float )


type alias Collage msg =
    { origin : Point
    , theta : Float
    , scale : Float
    , alpha : Float
    , basic : BasicCollage msg
    , handlers : List ( String, Json.Decoder msg )
    }


type BasicCollage msg
    = Shape ( FillStyle, LineStyle ) Shape
    | Path LineStyle Path
    | Text TextAnchor Text
    | Image String Float Float
    | Group (List (Collage msg))
    | Element (Html msg)


type Shape
    = Polygon (List Point)
    | Ellipse Float Float


type Path
    = Polyline (List Point)


type TextAnchor
    = Start
    | Middle
    | End


type FillStyle
    = Transparent
    | Uniform Color


type alias LineStyle =
    { fill : FillStyle
    , thickness : Float
    , cap : LineCap
    , join : LineJoin
    , dashing : List ( Int, Int )
    , dashOffset : Int
    }


type LineCap
    = Flat
    | Round
    | Padded


type LineJoin
    = Smooth
    | Sharp
    | Clipped