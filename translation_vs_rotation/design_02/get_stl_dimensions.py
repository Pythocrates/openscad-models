#! /usr/bin/env python3

''' Show the boundaries of an STL file.
'''

from pathlib import Path
import sys

from stl.mesh import Mesh


def main():
    in_path = Path(sys.argv[1])
    mesh = Mesh.from_file(in_path.as_posix())
    print(mesh[0::3, :].min())
    x0 = (mesh.x.min() + mesh.x.max()) / 2
    y0 = (mesh.y.min() + mesh.y.max()) / 2
    #z0 = (mesh.z.min() + mesh.z.max()) / 2
    z0 = mesh.z.min()

    print(f'Center: {x0}, {y0}, {z0}')
    out_path = f'{in_path.stem}_0.stl'
    print(out_path)

    mesh.x -= x0
    mesh.y -= y0
    mesh.z -= z0

    mesh.save(out_path)


if __name__ == '__main__':
    main()
