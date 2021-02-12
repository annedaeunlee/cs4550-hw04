defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    # expr
    # |> String.split(~r/\s+/)
    # |> hd
    # |> parse_float
    # |> :math.sqrt()

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching

    loi = String.split(expr)
    # operands = []
    # answer = []

    loi = Enum.map(loi, fn token ->
      case token do
        "+" -> {:op, token}
        "-" -> {:op, token}
        "/" -> {:op, token}
        "*" -> {:op, token}
        _ -> {:num, parse_float(token)}        
      end end
    )


    postfix = recursion(loi, [], [])
    #postfix is answer

    calc_stack = []
    evaluate(postfix, calc_stack)
  end

  
  
  
  def recursion(loi, operands, answer) do

    # if (length(loi) == 0) do
    #   IO.inspect(answer ++ operands)
    #   answer ++ operands
    # end


    # IO.inspect(next)
    # IO.inspect(answer)
    # IO.inspect(operands)

    cond do
      (loi == []) ->
        answer ++ operands
      (elem(hd(loi), 1) == "+" || elem(hd(loi), 1) == "-") ->
        next = elem(hd(loi), 1)
        cond do
          (operands == []) ->
            operands = [next] ++ operands
            recursion(tl(loi), operands, answer)
          (hd(operands) == "*" || hd(operands) == "/") ->
            answer = answer ++ [hd(operands)]
            operands = operands -- [hd(operands)]
            operands = [next] ++ operands
            recursion(tl(loi), operands, answer)
          true ->
            operands = [next] ++ operands 
            recursion(tl(loi), operands, answer)
        end

      (elem(hd(loi), 1) == "*" || elem(hd(loi), 1) == "/") ->
        next = elem(hd(loi), 1)
        cond do
          (operands == []) ->
            operands = [next] ++ operands
            recursion(tl(loi), operands, answer)
          (hd(operands) == "+" || hd(operands) == "-") ->
            operands = [next] ++ operands
            recursion(tl(loi), operands, answer)
          (hd(operands) == "*" || hd(operands) == "/") ->
            answer = answer ++ [hd(operands)]
            operands = operands -- [hd(operands)]
            operands = [next] ++ operands
            recursion(tl(loi), operands, answer)
        end

      true ->
        next = elem(hd(loi), 1)
        answer = answer ++ [next]
        recursion(tl(loi), operands, answer)
    end

  end



  def evaluate(postfix, calc_stack) do
    

    # IO.inspect(postfix)
    # IO.inspect(calc_stack)

    cond do

      (postfix == []) ->
        hd(calc_stack)

      (hd(postfix) == "+") ->
        eval = hd(calc_stack) + hd(tl(calc_stack))
        calc_stack = calc_stack -- [hd(calc_stack)]
        calc_stack = calc_stack -- [hd(calc_stack)]
        calc_stack = [eval] ++ calc_stack
        evaluate(tl(postfix), calc_stack)
      
      (hd(postfix) == "-") ->
        eval = hd(tl(calc_stack)) - hd(calc_stack)
        calc_stack = calc_stack -- [hd(calc_stack)]
        calc_stack = calc_stack -- [hd(calc_stack)]
        calc_stack = [eval] ++ calc_stack
        evaluate(tl(postfix), calc_stack)

      (hd(postfix) == "*") ->
        eval = hd(calc_stack) * hd(tl(calc_stack))
        calc_stack = calc_stack -- [hd(calc_stack)]
        calc_stack = calc_stack -- [hd(calc_stack)]
        calc_stack = [eval] ++ calc_stack
        evaluate(tl(postfix), calc_stack)

      (hd(postfix) == "/") ->
        eval = hd(tl(calc_stack)) / hd(calc_stack)
        calc_stack = calc_stack -- [hd(calc_stack)]
        calc_stack = calc_stack -- [hd(calc_stack)]
        calc_stack = [eval] ++ calc_stack
        evaluate(tl(postfix), calc_stack)

      true ->
        calc_stack = [hd(postfix)] ++ calc_stack
        evaluate(tl(postfix), calc_stack)
    end

  end







end
