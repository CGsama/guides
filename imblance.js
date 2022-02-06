var operator = {
	">": (a, b) => {return a > b;},
	">=": (a, b) => {return a >= b;},
	"<": (a, b) => {return a < b;},
	"<=": (a, b) => {return a <= b;},
	}
function foo(arr, rev, op){
	arr = rev ? arr.reverse() : arr;
	count = [];
	ltls = [];
	i = 0;
	while(i < arr.length){
		count[i] = 0;
		while(operator[op](arr[ltls[ltls.length - 1]], arr[i]) && ltls.length > 0){
			count[i] += count[ltls[ltls.length - 1]] + 1;
			ltls = ltls.slice(0, -1);
		}
		ltls[ltls.length] = i
		i++;
	}
	return rev ? count.reverse() : count;
}

arr = [4,3,2,3,4];

a = foo(arr,true,">");
b = foo(arr,false,">=");
c = foo(arr,true,"<");
d = foo(arr,false,"<=");

a.map((x,i)=>(x+1)*(b[i]+1)*arr[i]).reduce((x,y)=>x+y) - c.map((x,i)=>(x+1)*(d[i]+1)*arr[i]).reduce((x,y)=>x+y)
