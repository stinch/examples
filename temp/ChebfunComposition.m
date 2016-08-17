%% Compose!
% Olivier S&egrave;te, August 2016

%%
% (Chebfun example temp/ChebfunComposition.m)

%% The composition with chebfuns
% The composition of two functions, $g(f)$, is one of the basic operations which
% can be done in Chebfun, e.g.,

f = chebfun(@(t) cos(t));
g = chebfun(@(t) exp(t));
h = g(f)

%%
% The same is possible for all combinations of objects from Chebfun, Chebfun2
% and Chebfun3, so that the composition makes sense. We present a few examples
% and start with a chebfun of a Chebfun2:

f = chebfun2(@(x,y) x.^2 + y);
g = chebfun(@(t) exp(cos(10*t)), [-2, 2]);
h = g(f)
plot(h)

%%
% The chebfun can also have two or three columns, resulting in a Chebfun2v
% object:

g = chebfun(@(t) [ t, t.^2 ]);
h = g(f)

%%
% Replacing $f$ by a Chebfun3 object works too and gives a Chebfun3 or
% Chebfun3v object, depending on the number of columns of the chebfun $g$.


%% A Chebfun2 of...
% any object $f$ that maps to $\mathbf{R}^2$ ! Let us start with the composition
% of a Chebfun2 object $g$ with a chebfun, which is the restriction of $g$ to a
% curve in 2d space.  As an easy example let

g = chebfun2(@(x,y) x.^2 + y.^2);
f = chebfun(@(t) [ cos(t), sin(t) ], [ -pi, pi ]);

%%
% The composition |g(f)| is of course the constant chebfun $1$ on $[-\pi, \pi]$:
h = g(f)
plot(h)


%%
% Similarly we can compose $g$ with a Chebfun2v or a Chebfun3v object that maps
% to $\mathbf{R}^2$, and the result is a Chebfun2 or Chebfun3, respectively. In
% particular we can thus consider $g$ on a non-rectangular domain parametrized
% by $f$:

f = chebfun2v(@(x,y) x + y, @(x,y) y, [0, 1, 0, 1]);
g = chebfun2(@(x,y) sin(5*x.^2).*y.^4, [0, 2, 0, 1]);
h = g(f)
plot(h)

%%
% Of course the same is possible if $g$ is a Chebfun2v object.  Try it with your
% favourite functions!

%% The complex plane
% Before we move on to Chebfun3 and Chebfn3v objects $g$, let us explore one
% particularity in 2d:  the real and complex plane can be identified.
% Accordingly, a single input of a Chebfun2 or Chebfun2v object is interpreted
% as a complex input: |g(z)| is the same as |g(real(z), imag(z))|.  This is true
% for points,

g = chebfun2(@(x,y) 2*x + 3i*y);
g(0.5 + 1i)
g(0.5, 1)

%%
% and for function inputs as well.  We can compose $g$ with a chebfun, Chebfun2
% or Chebfun3 object.  For instance, a parametrization of the complex unit
% circle gives the same result as with the real parametrization from above:

fr = chebfun(@(t) [ cos(t), sin(t) ], [ -pi, pi ]);
fc = chebfun(@(t) exp(1i*t), [ -pi, pi ]);
g = chebfun2(@(x,y) x.^2 + y.^2);
hr = g(fr);
hc = g(fc);
norm(hr - hc)

%% Moving to 3d
% Given a Chebfun3 or Chebfun3v object, we can compose it with anything mapping
% to $\mathbf{R}^3$: a chebfun describing a curve, a Chebfun2v object describing
% a surface, or a Chebfun3v object parametrizing a possibly non-rectangular
% domain.

%%
% As an example, let $f$ be a helix and let $g$ measure the distance to
% $(1,2,3)$:

f = chebfun(@(t) [ cos(2*pi*t), sin(2*pi*t), t ], [0, 10]);
plot3(f(:,1), f(:,2), f(:,3))

%%
g = chebfun3(@(x,y,z) (x-1).^2 + (y-2).^2 + (z-3).^2);
h = g(f)
plot(h)

%%
% The restriction of a Chebfun3 to a surface is equally easy:

f = chebfun2v(@(x,y) sin(x).*cos(y), @(x,y) sin(x).*sin(y), @(x,y) cos(x), ...
    [0, pi/2, 0, 2*pi]);
g = chebfun3(@(x,y,z) x + y + z);
h = g(f)
plot(h)
