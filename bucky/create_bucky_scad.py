#! /usr/bin/env python3

'''Create an OpenSCAD file for a buckyball from a coordinate list of the
vertces.
'''


import logging
from math import atan2, degrees, sqrt

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.DEBUG)


class Vertex:
    def __init__(self, x, y, z, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.__x, self.__y, self.__z = x, y, z

    @property
    def position(self):
        return self.__x, self.__y, self.__z

    @property
    def norm(self):
        return sqrt(self.__x ** 2 + self.__y ** 2 + self.__z ** 2)

    def scale(self, s):
        self.__x, self.__y, self.__z = self.__x * s, self.__y * s, self.__z * s


class Cylinder:
    def __init__(
        self, radius, height, position, rotation, fn,
        *args, **kwargs
    ):
        super().__init__(*args, **kwargs)
        self.__radius = radius
        self.__height = height
        self.__position = position
        self.__rotation = rotation
        self.__fn = fn

    @property
    def position(self):
        return self.__position

    @property
    def rotation(self):
        return self.__rotation

    @property
    def radius(self):
        return self.__radius

    @property
    def height(self):
        return self.__height

    @property
    def fn(self):
        return self.__fn


class Sphere:
    def __init__(self, position, radius, fn, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.__position = position
        self.__radius = radius
        self.__fn = fn

    @property
    def position(self):
        return self.__position

    @property
    def radius(self):
        return self.__radius

    @property
    def fn(self):
        return self.__fn


class CylinderBuilder:
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.__radius = 1.
        self.__height = 1.
        self.__position = 0., 0., 0.
        self.__rotation = 0., 0., 0.

    def starting_at(self, sphere):
        self.__position = None
        self.__position_0 = sphere.position
        self.__radius = sphere.radius
        return self

    def ending_at(self, sphere):
        self.__position = None
        self.__position_1 = sphere.position
        # self.__radius = sphere.radius  # TODO: different radii start/end?
        return self

    def build(self, fn=10):
        position = self.__position or tuple((
            0.5 * (v0 + v1)
            for (v0, v1) in zip(self.__position_0, self.__position_1)
        ))
        logger.debug(f'Position: {position}')

        dx = self.__position_1[0] - self.__position_0[0]
        dy = self.__position_1[1] - self.__position_0[1]
        dz = self.__position_1[2] - self.__position_0[2]
        return Cylinder(
            radius=self.__radius,
            height=sqrt(dx ** 2 + dy ** 2 + dz ** 2),
            position=position,
            rotation=(
                0,
                degrees(atan2(dz, sqrt(dx ** 2 + dy ** 2))),
                degrees(atan2(dy, dx)),
            ),
            fn=fn
        )


def main():
    vertices = list()
    edges = list()
    max_radius = 0

    with open('C60-Ih.xyz') as bucky_file:
        for line in bucky_file:
            try:
                x, y, z, index, *neighbors = line.split()[1:]
            except ValueError:
                logger.debug(f'Skipping {line.strip()}.')
            else:
                vertex = Vertex(float(x), float(y), float(z))
                max_radius = max(max_radius, vertex.norm)
                vertices.append(vertex)
                index = int(index) - 1
                for neighbor in neighbors:
                    neighbor = int(neighbor) - 1
                    if (neighbor, index) not in edges:
                        edges.append((index, neighbor))

    logger.debug(f'{len(vertices)} nodes and {len(edges)} edges found.')

    primitives = list()

    outer_radius = 40
    tube_radius = 2
    fn = 30
    for vertex in vertices:
        vertex.scale(1 / max_radius)
        sphere = Sphere(
            position=tuple(outer_radius * pi for pi in vertex.position),
            radius=tube_radius,
            fn=fn
        )
        primitives.append(sphere)

    for i0, i1 in edges:
        p0 = primitives[i0]
        p1 = primitives[i1]
        cylinder = (
            CylinderBuilder().starting_at(sphere=p0).ending_at(sphere=p1)
            .build(fn=fn)
        )
        primitives.append(cylinder)

    with open('bucky.scad', 'w') as bucky_file:
        for p in primitives:
            if isinstance(p, Sphere):
                print(
                    f'translate([{", ".join(str(i) for i in p.position)}]) '
                    f'sphere(r={p.radius}, $fn={p.fn});',
                    file=bucky_file
                )
            elif isinstance(p, Cylinder):
                print(
                    f'translate([{", ".join(str(i) for i in p.position)}]) '
                    f'rotate(v=[0, 0, 1], a={p.rotation[2]})'
                    f'rotate(v=[0, 1, 0], a=90)'
                    f'rotate(v=[0, 1, 0], a={-p.rotation[1]})'
                    f'cylinder(r={p.radius}, h={p.height}, $fn={p.fn}, '
                    f'center=true);',
                    file=bucky_file
                )


if __name__ == '__main__':
    main()
