
    <? class db
    {
        public $isConnected;
        protected $datab;
        public function __construct($username, $password, $host, $dbname, $options=array()){
            $this->isConnected = true;
            try { 
                $this->datab = new PDO("mysql:host={$host};dbname={$dbname};charset=utf8", $username, $password, $options); 
                $this->datab->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
                $this->datab->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
            } 
            catch(PDOException $e) { 
                $this->isConnected = false;
                throw new Exception($e->getMessage());
            }
        }
        public function Disconnect(){
            $this->datab = null; 
            $this->isConnected = false; 
        }
        public function getRow($query, $params=array()){
            try{ 
                $stmt = $this->datab->prepare($query); 
                $stmt->execute($params);
                return $stmt->fetch();  
                }catch(PDOException $e){
                throw new Exception($e->getMessage());
            }
        }
        public function getRows($query, $params=array()){
            try{ 
                $stmt = $this->datab->prepare($query); 
                $stmt->execute($params);
                return $stmt->fetchAll();       
                }catch(PDOException $e){
                throw new Exception($e->getMessage());
            }       
        }
        public function insertRow($query, $params){
            try{ 
                $stmt = $this->datab->prepare($query); 
                $stmt->execute($params);
                }catch(PDOException $e){
                throw new Exception($e->getMessage());
            }           
        }
        public function updateRow($query, $params){
            return $this->insertRow($query, $params);
        }
        public function deleteRow($query, $params){
            return $this->insertRow($query, $params);
        }
    }

    $db = new db("root", "123RO1C", "localhost", "health_care", array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'));




    ?>