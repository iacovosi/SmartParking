<?php

include 'class.database.php';


try {
	
	//read the places and insert them in the database
	//get connection singleton
	$db = Database::getInstance();
	$mysqli = $db->getConnection();

    $mng = new MongoDB\Driver\Manager("mongodb://localhost:27017");
	$query = new MongoDB\Driver\Query([]); 
	 
	$rows = $mng->executeQuery("parking15.lots", $query); 

	foreach ($rows as $row) {
        echo print_r($row,true)."\n";
		$stmt = $mysqli->prepare("INSERT INTO `smartParking`.`places` (`name`,`loc`,`lat`, `long`, `disabledcount`, `empty`,`avaliable`,`user_id`,`cost`, `parkingtype_id`, `capacity`,`time`,`created_at`,`updated_at`,`reportedcount`,`maximumduration`) VALUES (?,POINT(".$row->loc[0].",".$row->loc[1]."),?, ?, ?, ?, ?, ?,?,?,?,?,?,?,?,?);");
		$name=empty($row->name)?"NO NAME":$row->name;
		$disabledcount=empty($row->disabledcount)?0:$row->disabledcount;
		$empty=empty($row->empty)?0:$row->empty;
		$avaliable=empty($row->avaliable)?0:$row->avaliable;
		$user= ($row->user<1003)?1003:$row->user;
		$cost=empty($row->cost)?0:$row->cost;
		$type=6;
		$capacity=empty($row->capacity)?0:$row->capacity;
		$time=empty($row->time)?date("Y-m-d H:i:s"):date("Y-m-d H:i:s", $row->time);
		$now=date("Y-m-d H:i:s");
		$reportedcount=$capacity;
		$maximumduration=0;
		$stmt->bind_param("sddiiiidiisssii",$name, $row->loc[0], $row->loc[1],$disabledcount,$empty,$avaliable,$user,$cost,$type,$capacity,$time,$now,$now,$reportedcount,$maximumduration);
		$stmt->execute();
		if (!empty($stmt->error)) {
			printf("Error: %s.\n", $stmt->error);
		}
		$stmt->close();
	
    }

	$rows = $mng->executeQuery("parking15.places", $query);

	foreach ($rows as $row) {
        echo print_r($row,true)."\n";
		$stmt = $mysqli->prepare("INSERT INTO `smartParking`.`places` (`name`,`loc`,`lat`, `long`, `disabledcount`, `empty`,`avaliable`,`user_id`,`cost`, `parkingtype_id`, `capacity`,`time`,`created_at`,`updated_at`,`reportedcount`,`maximumduration`) VALUES (?,POINT(".$row->loc[0].",".$row->loc[1]."),?, ?, ?, ?, ?, ?,?,?,?,?,?,?,?,?);");
		$name=empty($row->name)?"NO NAME":$row->name;
		$disabledcount=empty($row->disabledcount)?0:$row->disabledcount;
		$empty=empty($row->empty)?0:$row->empty;
		$avaliable=empty($row->avaliable)?0:$row->avaliable;
		$user= ($row->user<1003)?1003:$row->user;
		$cost=empty($row->cost)?0:$row->cost;
		$type=7;
		$capacity=empty($row->capacity)?0:$row->capacity;
		$time=empty($row->time)?date("Y-m-d H:i:s"):date("Y-m-d H:i:s", $row->time);
		$now=date("Y-m-d H:i:s");
		$reportedcount=$capacity;
		$maximumduration=0;		
		$stmt->bind_param("sddiiiidiisssii",$name, $row->loc[0], $row->loc[1],$disabledcount,$empty,$avaliable,$user,$cost,$type,$capacity,$time,$now,$now,$reportedcount,$maximumduration);
		$stmt->execute();
		if (!empty($stmt->error)) {
			printf("Error: %s.\n", $stmt->error);
		}
		$stmt->close();
	
    }
	
     
	$rows = $mng->executeQuery("parking15.activity", $query);		
   
	foreach ($rows as $row) {
        echo print_r($row,true)."\n";
		$stmt = $mysqli->prepare("SELECT checkIfParkingExists(?,?) as result;");
		$stmt->bind_param("dd", $row->loc[0],$row->loc[1]);
		$stmt->execute();
		$result = $stmt->get_result();
		$places_id=0;
		if($result->num_rows === 0) exit('No rows');
		while($rowLoc = $result->fetch_assoc()) {
		  //print_r($row);
		  if (!empty($rowLoc['result'])) {
				$places_id=$rowLoc['result'];  
		  }
		  else {
				$stmt2 = $mysqli->prepare("INSERT INTO `smartParking`.`places` (`name`,`loc`,`lat`, `long`, `disabledcount`, `empty`,`avaliable`,`user_id`,`cost`, `parkingtype_id`, `capacity`,`time`,`created_at`,`updated_at`,`reportedcount`,`maximumduration`) VALUES (?,POINT(".$row->loc[0].",".$row->loc[1]."),?, ?, ?, ?, ?, ?,?,?,?,?,?,?,?,?);");
				$name="From Activity";
				$disabledcount=0;
				$empty=0;
				$avaliable=1;
				$user= ($row->user<1003)?1003:$row->user;
				$cost=0;
				$type=empty($row->type)?1:$row->type;
				$capacity=empty($row->reportedCount)?0:$row->reportedCount;
				$time=empty($row->time)?date("Y-m-d H:i:s"):date("Y-m-d H:i:s", $row->time);
				$now=date("Y-m-d H:i:s");
				$reportedcount=$capacity;
				$maximumduration=0;	
				$stmt2->bind_param("sddiiiidiisssii",$name, $row->loc[0], $row->loc[1],$disabledcount,$empty,$avaliable,$user,$cost,$type,$capacity,$time,$now,$now,$reportedcount,$maximumduration);
				$stmt2->execute();
				if (!empty($stmt2->error)) {
					printf("Error: %s.\n", $stmt2->error);
					$places_id=null;
				}
				else {
					$places_id=$mysqli->insert_id;
				}
				$stmt2->close();			  
		  }
		  
		}
		$stmt->close();				
/*
old with data
		$stmt = $mysqli->prepare("INSERT INTO `smartParking`.`activities` ( `parked`, `reported_count`,`user_id`, `parkingtype_id`, `places_id`,`time`,`created_at`,`updated_at`) VALUES (?, ?, ?, ?, ?, ?,?,?);");
		$parked=empty($row->parked)?0:$row->parked;
		$reportedCount=empty($row->reportedCount)?0:$row->reportedCount;
		$user= ($row->user<1003)?1003:$row->user;
		$type=empty($row->type)?1:$row->type;
		$time=empty($row->time)?date("Y-m-d H:i:s"):date("Y-m-d H:i:s", $row->time);
		$now=date("Y-m-d H:i:s");
		$stmt->bind_param("iiiiisss", $parked,$reportedCount,$user,$type,$places_id,$time,$now,$now);
		$stmt->execute();
		if (!empty($stmt->error)) {
			printf("Error: %s.\n", $stmt->error);
		}
		$stmt->close();	
*/	
		$stmt = $mysqli->prepare("INSERT INTO `smartParking`.`activities` ( `parked`, `user_id`, `places_id`,`time`,`created_at`,`updated_at`) VALUES (?, ?, ?, ?, ?, ?);");
		$parked=empty($row->parked)?0:$row->parked;
		$user= ($row->user<1003)?1003:$row->user;
		$time=empty($row->time)?date("Y-m-d H:i:s"):date("Y-m-d H:i:s", $row->time);
		$now=date("Y-m-d H:i:s");
		$stmt->bind_param("iiisss", $parked,$user,$places_id,$time,$now,$now);
		$stmt->execute();
		if (!empty($stmt->error)) {
			printf("Error: %s.\n", $stmt->error);
		}
		$stmt->close();		
    }
	
	
	$rows = $mng->executeQuery("parking15.bookmarks", $query);

	foreach ($rows as $row) {
        echo print_r($row,true)."\n";
		$places_id=0;
		if  (isset($row->loc) && is_array($row->loc) &&(!empty($row->loc[0]) && !empty($row->loc[1]))) {
			$stmt = $mysqli->prepare("SELECT checkIfParkingExists(?,?) as result;");
			$stmt->bind_param("dd", $row->loc[0],$row->loc[1]);
			$stmt->execute();
			$result = $stmt->get_result();
			if($result->num_rows === 0) exit('No rows');
			while($rowLoc = $result->fetch_assoc()) {
			  //print_r($row);
			  if (!empty($rowLoc['result'])) {
					$places_id=$rowLoc['result'];  
			  }
			  else {
					$stmt2 = $mysqli->prepare("INSERT INTO `smartParking`.`places` (`name`,`loc`,`lat`, `long`, `disabledcount`, `empty`,`avaliable`,`user_id`,`cost`, `parkingtype_id`, `capacity`,`time`,`created_at`,`updated_at`,`reportedcount`,`maximumduration`) VALUES (?,POINT(".$row->loc[0].",".$row->loc[1]."),?, ?, ?, ?, ?, ?,?,?,?,?,?,?,?,?);");
					$name="From BOOKMARK";
					$disabledcount=0;
					$empty=0;
					$avaliable=1;
					$user= ($row->user<1003)?1003:$row->user;
					$cost=0;
					$type=empty($row->type)?6:$row->type;
					$capacity=0;
					$time=empty($row->time)?date("Y-m-d H:i:s"):date("Y-m-d H:i:s", $row->time);
					$now=date("Y-m-d H:i:s");
					$reportedcount=$capacity;
					$maximumduration=0;	
					$stmt2->bind_param("sddiiiidiisss",$name, $row->loc[0], $row->loc[1],$disabledcount,$empty,$avaliable,$user,$cost,$type,$capacity,$time,$now,$now,$reportedcount,$maximumduration);
					$stmt2->execute();
					if (!empty($stmt2->error)) {
						printf("Error: %s.\n", $stmt2->error);
						$places_id=null;
					}
					else {
						$places_id=$mysqli->insert_id;
					}
					$stmt2->close();			  
			  }
			   
			}
			$stmt->close();				
		}
		$stmt = $mysqli->prepare("INSERT INTO `smartParking`.`bookmarks` (`temporary`,`description`,`user_id`,`parkingtype_id`,`places_id`, `time`,`created_at`,`updated_at`,`name`) VALUES (?, ?, ?, ?, ?, ?,?,?,?);");
		if (isset($row->name)) {
			$name=empty($row->name)?0:$row->name;
		}
		else {
			$name="No Name";
		}		
		if (isset($row->temporary)) {
			$temporary=empty($row->temporary)?0:$row->temporary;
		}
		else {
			$temporary=0;
		}
		if (isset($row->description)) {
			$description=empty($row->description)?"Not Description":$row->description;			
		}
		else {
			$description="Not Description";
		}
		if (isset($row->user)) {
			$user= ($row->user<1003)?1003:$row->user;			
		}
		else {
			$user==1003;
		}
		if (isset($row->type)) {
			$type=empty($row->type)?1:$row->type;		
		}
		else {
			$type=1;
		}
		$time=empty($row->time)?date("Y-m-d H:i:s"):date("Y-m-d H:i:s", $row->time);
		$now=date("Y-m-d H:i:s");
		$stmt->bind_param("isiiissss", $temporary,$description,$user,$type,$places_id,$time,$now,$now,$name);
		$stmt->execute();
		if (!empty($stmt->error)) {
			printf("Error: %s.\n", $stmt->error);
		}
		$stmt->close();	
	
    }	
	
	$rows = $mng->executeQuery("parking15.target", $query);
	foreach ($rows as $row) {
        echo print_r($row,true)."\n";
		$stmt = $mysqli->prepare("INSERT INTO `smartParking`.`targets` (`loc`,`lat`, `long`,`user_id`,`time`,`created_at`,`updated_at`) VALUES (?,POINT(".$row->loc[0].",".$row->loc[1]."),?, ?, ?, ?, ?);");
		$user= ($row->user<1003)?1003:$row->user;
		$time=empty($row->time)?date("Y-m-d H:i:s"):date("Y-m-d H:i:s", $row->time);
		$now=date("Y-m-d H:i:s");
		$stmt->bind_param("sddisss",$name, $row->loc[0], $row->loc[1],$user,$time);
		$stmt->execute();
		if (!empty($stmt->error)) {
			printf("Error: %s.\n", $stmt->error);
		}
		$stmt->close();
	
    }		
	
	
} catch (MongoDB\Driver\Exception\Exception $e) {

    $filename = basename(__FILE__);
    
    echo "The $filename script has experienced an error.\n"; 
    echo "It failed with the following exception:\n";
    
    echo "Exception:", $e->getMessage(), "\n";
    echo "In file:", $e->getFile(), "\n";
    echo "On line:", $e->getLine(), "\n";       
}

?>