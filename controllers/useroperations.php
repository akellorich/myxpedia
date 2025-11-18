<?php
    require_once("../models/users.php");
    $user=new user();
    
    if(isset($_POST['saveuser'])){
        $userid=$_POST['userid'];
        $username=$_POST['username'];
        $firstname=$_POST['firstname'];
        $lastname=$_POST['lastname'];
        $password=$_POST['password'];
        // generate salt'
        $salt=generateRandomString(20);
        // has the password with salt
        $userpassword=hash('SHA256',$password.$salt);
        $mobile=$_POST['mobile'];
        $email=$_POST['emailaddress'];
        $systemadmin=$_POST['systemadmin'];
        $response=$user->saveuser($userid,$username,$firstname,$lastname,$userpassword,$salt,$mobile,$email,$systemadmin);
        if($response['status']!=="exists"){
            $userid=$response['userid'];
            // var_dump($response);
            $userprivileges=json_decode(stripcslashes($_POST['userprivileges']),true);

            foreach($userprivileges as $userprivilege){
                $objectid=$userprivilege['objectid'];
                $valid=$userprivilege['valid'];
                // save the privilege
                $user->saveuserprivilege($userid,$objectid,$valid);
            }
        }
        
        // save user privileges
        echo json_encode($response);
    }

    if(isset($_GET['getusers'])){
        echo $user->getusers();
    }

    if(isset($_GET['getuserdetails'])){
        $userid=$_GET['userid'];
        echo $user->getuserdetails($userid);
    }

    if(isset($_GET['getobjects'])){
        echo $user->getobjects();
    }

?>