defmodule Practice.Factor do


def factor(x) do 

    stack = []

    stackx = div_two(stack, x)

    stack = hd(stackx)
    x = hd(tl(stackx))

    i = 3

    stackx2 = rest_factors(stack, x, i)

    stack = hd(stackx2)
    x = hd(tl(stackx2))

    stack

end

#return last number not divisible by 2
def div_two(stack, x) do
    cond do 
        (rem(x, 2) != 0) ->
            [stack, x]
        true ->
            stack = stack ++ [2]
            div_two(stack, div(x,2))
    end
end

def rest_factors(stack, x, i) do
    cond do
        (x == 1) ->
            [stack, x]
        (i > :math.sqrt(x)) ->
            stack = stack ++ [x]
            [stack, x]
        (rem(x, i) != 0) ->
            rest_factors(stack, x, i+2)
        true ->
            stack = stack ++ [i]
            rest_factors(stack, div(x,i), i)
    end
end



end