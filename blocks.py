import check

class Block:
    def __init__(self, **kwargs):
        '''
        Initiates a Block by setting the value of all its sides
        '''
        for key, value in kwargs.items():
            setattr(self, key, value)

    def __repr__(self):
        '''
        Represents a block by displaying the value of each side
        '''
        return "front:{0}\nright:{1}\nback:{2}\nleft:{3}\ntop:{4}\nbottom:{5}".format(
        self.front, self.right, self.back, self.left, self.top, self.bottom)

    def rotate(self):
        '''
        Rotates a Block clockwise when looking from above
        '''
        front = self.front
        self.front = self.right
        self.right = self.back
        self.back = self.left
        self.left = front

    def flip(self):
        '''
        Flips a Block clockwise when looking from the right
        '''
        front = self.front
        self.front = self.bottom
        self.bottom = self.back
        self.back = self.top
        self.top = front


## BLOCKS

black = Block(
	front='e',
	right='c',
	back='m',
	left='e',
	top='m',
	bottom='=')
red = Block(
	front='=',
	right='=',
	back='m',
	left='=',
	top='e',
	bottom='c')
spruce = Block(
	front='=',
	right='c',
	back='e',
	left='=',
	top='m',
	bottom='e')
birch = Block(
	front='=',
	right='m',
	back='c',
	left='m',
	top='c',
	bottom='e')


def is_unique(s1, s2, s3, s4):
	if s1 == s2:
		return False
	if s1 == s3:
		return False
	if s1 == s4:
		return False
	if s2 == s3:
		return False
	if s2 == s4:
		return False
	if s3 == s4:
		return False
	return True


def is_solved(b1, b2, b3, b4):
    return is_unique(b1.front, b2.front, b3.front, b4.front) and \
           is_unique(b1.top, b2.top, b3.top, b4.top) and \
           is_unique(b1.back, b2.back, b3.back, b4.back) and \
           is_unique(b1.bottom, b2.bottom, b3.bottom, b4.bottom)


def solve(b1, b2, b3, b4):
	state = [b1, b2, b3, b4]
	counter = 0
	rotations = {
		1:0,
		2:0,
		3:0,
		4:0}
	flips = {
		1:0,
		2:0,
		3:0,
		4:0}
	while flips[1] < 4:
		if is_solved(b1, b2, b3, b4):
			for block in state:
				print(block)
				print('\n')
			print(counter)
			return
		elif flips[4] == 4:
			b3.flip()
			flips[3] += 1
			flips[4] = 0
		elif flips[3] == 4:
			b2.flip()
			flips[2] += 1
			flips[3] = 0
		elif flips[2] == 4:
			b1.flip()
			flips[1] += 1
			flips[2] = 0
		elif rotations[4] == 4:
			b3.rotate()
			rotations[3] += 1
			rotations[4] = 0
		elif rotations[3] == 4:
			b2.rotate()
			rotations[2] += 1
			rotations[3] = 0
		elif rotations[2] == 4:
			b1.rotate()
			rotations[1] += 1
			rotations[2] = 0
		elif rotations[1] == 4:
			b4.flip()
			flips[4] += 1
			rotations[1] = 0
		else:
			b4.rotate()
			rotations[4] += 1
		counter +=1
	return 'No solution'


check.set_screen("prints number of moves and block states")
check.expect("test1", solve(red, spruce, birch, black), None)
