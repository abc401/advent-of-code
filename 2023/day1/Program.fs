open System

exception Unreachable

let charToInt char = int char - int '0'

let recover =
    let rec recoverAux firstDigit lastDigit line =
        match (firstDigit, lastDigit) with
        | (None, None) ->
            match line with
            | firstDigit :: rest when Char.IsDigit firstDigit ->
                recoverAux (Some(charToInt firstDigit)) (Some(charToInt firstDigit)) rest
            | _ :: rest -> recoverAux None None rest
            | [] -> None
        | (Some(firstDigit), Some(lastDigit)) ->
            match line with
            | char :: rest when Char.IsDigit char -> recoverAux (Some(firstDigit)) (Some(charToInt char)) rest
            | _ :: rest -> recoverAux (Some(firstDigit)) (Some(lastDigit)) rest
            | [] -> Some(firstDigit * 10 + lastDigit)
        | _ -> raise Unreachable

    recoverAux None None

let part1 =
    let lines = IO.File.ReadLines "input.txt"

    let mutable result = 0

    for line in lines do
        match line |> Seq.toList |> recover with
        | Some(recovered) -> result <- result + recovered
        | None -> raise Unreachable

    result

printfn "result: %d" part1
