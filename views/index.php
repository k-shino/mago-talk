<html>
<head>
	<link rel="stylesheet" type="text/css" href="styles.css" />
</head>
<body>
	<div id="wrapper">
		
<?php

function print_ping($host)
{
	echo "<HR>PING TEST : ".$host;
	echo " ";
	$r = exec(sprintf('ping -c 1 -W 5 %s', escapeshellarg($host)),$res, $rval);
	echo $rval ? 'up' : 'down';
	echo "<br>";
	return 1;
}

function print_curl($host)
{
	echo "<HR>CURL TEST : ".$host." ";
        $crl = exec(sprintf('curl %s', escapeshellarg($host)),$res, $rval);
        echo count($res);// ? 'up' : 'down';
	echo "<br>";
}

function print_ifconfig()
{
	echo "IN-CONTAINER IFCONFIG</BR><pre>";
	exec ("ifconfig", $ifconfig);
	print_r($ifconfig);
	echo "</pre><hr>";
	return 1;
}

function print_brctl()
{
        echo "IN-CONTAINER BRCTL</BR><pre>";
        exec ("brctl show", $brctl);
        print_r($brctl);
        echo "</pre><hr>";
        return 1;
}

function print_route()
{
        echo "IN-CONTAINER ROUTE</BR><pre>";
        exec ("route -n", $route);
        print_r($route);
        echo "</pre><hr>";
        return 1;
}

echo "<div class=\"balloon\"><br/>";
echo "IP(VM) = ";
echo $_ENV["CF_INSTANCE_IP"];
echo "<br/>";
echo "IP(Container) =";
echo $_SERVER["SERVER_ADDR"];
echo "</div>";
echo "<br/>";
echo "<img src=\"logo.png\" width=\"400px\" />";
echo "<br/><br/>";



echo "<hr>";
if(isset($_GET["ip"]))
{
        $addr = $_GET["ip"];
        if(isset($_GET["port"]))
                $addr .= $_GET["port"];

        $addr = "http://".$addr."/phpinfo.php";
	echo "phpinfo(remote container)<br>";
	$response = http_get($addr, array("timeout"=>1), $info);
        echo $response;
}

echo "phpinfo(local container)";
phpinfo(INFO_VARIABLES);

// IFCONFIG
print_ifconfig();

// BRCTL
print_brctl();

// ROUTE
print_route();

// PRINT IP Address/Port
echo "MY IP ";
echo $_ENV["CF_INSTANCE_IP"];
echo ":";
echo $_ENV["CF_INSTANCE_PORT"];
echo "</BR><hr/>";

print_ping("localhost");
print_ping("127.0.0.1");
print_ping($_ENV["CF_INSTANCE_IP"]);
print_curl($_ENV["CF_INSTANCE_IP"]);

if(isset($_GET["ip"]))
{
        $addr = $_GET["ip"];
        if(isset($_GET["port"]))
                $addr .= $_GET["port"];
	print_curl($addr);

	echo "<hr/><br>http_get : ".$addr."</br>";
	echo "<pre>";
	print_r($info);
	echo "</pre>";
}

?>
	</div>
</body>
</html>
