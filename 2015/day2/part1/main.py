

def required_paper(l: int, w: int, h: int):
    area1 = l*w
    area2 = w*h
    area3 = h*l
    return 2*area1 + 2*area2 + 2*area3 + min(area1, area2, area3)


def main():
    with open('input') as file:
        lines = file.read().strip().split('\n')
    lines = [line.split('x') for line in lines]
    lines = [
        [int(num) for num in line]
        for line in lines
    ]
    total = sum([required_paper(*dimensions) for dimensions in lines])

    print(f'Total: {total}')


if __name__ == '__main__':
    main()