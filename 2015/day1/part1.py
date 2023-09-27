def main():
    with open('input.txt') as file:
        instructions = file.read()
    floor = 0
    for char in instructions:
        if char == '(':
            floor += 1
        elif char == ')':
            floor -= 1
    print(f'Santa reaches floor: {floor}')

if __name__ == '__main__':
    main()