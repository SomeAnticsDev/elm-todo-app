module Main exposing (main)

import Browser
import Css
import Html.Styled exposing (..)
import Html.Styled.Events exposing (..)
import Html.Styled.Attributes exposing (..)

type Msg = UpdateNewTodo String | SubmitTodo | RemoveTodo Int
type alias Model = { newTodo : String, todos: List Todo }
type alias Todo = { task : String, completed : Bool, id : Int }

main : Program () Model Msg
main =
    Browser.sandbox { init = { newTodo = "Greet the chat", todos = []}, update = update, view = view >> Html.Styled.toUnstyled }


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateNewTodo todo -> { model | newTodo = todo }
        SubmitTodo -> { model | todos = (model.todos ++ [ { task = model.newTodo, completed = False, id = List.length model.todos } ]), newTodo = "" }
        RemoveTodo id -> { model | todos = (List.filter (.id >> (/=) id) model.todos) }



view : Model -> Html Msg
view model =
    div [ css [Css.maxWidth (Css.ch 40) ] ]
        [ 
            ul [] (List.map (\todo -> li [] [ text todo.task, button [onClick (RemoveTodo todo.id)] [text "yeet"] ]) model.todos)
            ,Html.Styled.form [ onSubmit SubmitTodo ] [
                input [value model.newTodo, onInput UpdateNewTodo] []
                ,button [ type_ "submit" ] [ text "Submit" ]
                ]
        ]