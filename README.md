# Mowers & Co

Only Ruby runtime is necessary.
To run this program, you should execute :
`ruby main.rb /path/to/file`

If you don't have a `ruby` runtime, you could run a Docker : 
```
▶ docker build -t mowers .
▶ docker run -ti --rm -v path/to/file:/file mowers
```

example:
```
▶ docker run -ti --rm -v ~/Downloads/565GffSA/sample.txt:/file mowers
1 2 N
5 1 E
```

## playing with tests

```
▶ ./play_test.sh
```