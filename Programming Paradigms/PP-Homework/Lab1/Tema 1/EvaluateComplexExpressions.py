import re
def precedence(symbol):
    if symbol == '(' or symbol == ')':
        return 0
    elif symbol in '+-':
        return 1
    elif symbol in '*/':
        return 2
    else:
        return 3


def infix_to_prefix_express(infix_express):
    infix_express = infix_express[::-1]

    post_express = ""
    symbol_stack = []
    prev_symbol = '*'

    for symbol in infix_express:
        if symbol == ' ':
            continue
        elif symbol == ')':
            symbol_stack.append(symbol)
        elif symbol == '(':
            post_express += ' ' + symbol_stack.pop() + ' '
            symbol_popped = symbol_stack.pop()
            while symbol_popped != ')':
                post_express += ' ' + symbol_stack.pop() + ' '
                symbol_popped = symbol_stack.pop()
        elif symbol in '+-/*':
            while not symbol_stack == [] and precedence(symbol_stack[-1]) > precedence(symbol):
                post_express += ' ' + symbol_stack.pop() + ' '
            symbol_stack.append(symbol)
        else:
            if not prev_symbol.isdigit():
                post_express += ' ' + symbol
            else:
                post_express += symbol

        prev_symbol = symbol

    while not symbol_stack == []:
        post_express += ' ' + symbol_stack.pop() + ' '

    post_express = re.sub(r' {2,}', ' ', post_express)

    if post_express[-1] == ' ':
        post_express = post_express[:len(post_express) - 1]

    return post_express[::-1]


class Node:
    def __init__(self, ch=''):
        self.data = ch
        self.right = self.left = None


class ExpressionTree:
    def __init__(self, infix_express):
        self.root = Node()
        self.prefix_express = infix_to_prefix_express(infix_express).split(' ')
        self.root, pref_express = self.build_expression_tree_from_prefix(self.prefix_express)

    def build_expression_tree_from_prefix(self, pref_express):
        if pref_express == '':
            return ''

        if not pref_express[0] in '+-*/'"":
            return Node(pref_express[0]), pref_express[1:]
        else:
            root = Node(pref_express[0])
            root.left, new_express = self.build_expression_tree_from_prefix(pref_express[1:])
            root.right, new_express = self.build_expression_tree_from_prefix(new_express)

            return root, new_express


def evaluate_expression_tree(root):
    if root is None:
        return 0

    if root.left is None and root.right is None:
        return int(root.data)

    left_sum = evaluate_expression_tree(root.left)
    right_sum = evaluate_expression_tree(root.right)

    if root.data == '+':
        return left_sum + right_sum
    elif root.data == '-':
        return left_sum - right_sum
    elif root.data == '*':
        return left_sum * right_sum
    else:
        return left_sum / right_sum


# class EvaluateComplexExpressions:
#     def __init__(self, infix_express):
#         self.pref_express = infix_to_prefix_express(infix_express)
#         self.root = ExpressionTree(self.pref_express)
#
#     def evaluate_expression_tree(self):
#         if self.root is None:
#             return 0
#
#         if self.left is None and self.root.right is None:
#             return int(self.root.data)
#
#         left_sum = self.evaluate_expression_tree(self.root.left)
#         right_sum = self.evaluate_expression_tree(self.root.right)
#
#         if next_root.data == '+':
#             return left_sum + right_sum
#         elif next_root.data == '-':
#             return left_sum - right_sum
#         elif next_root.data == '*':
#             return left_sum * right_sum
#         else:
#             return left_sum / right_sum

