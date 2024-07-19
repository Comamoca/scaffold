import tink.unit.*;
import tink.unit.Assert.*;
import tink.testrunner.*;
import basic.Main;

class Main {
    static function main() {
        Runner.run(TestBatch.make([new Test(),])).handle(Runner.exit);
    }
}

class Test {
    public function new() {}

    public function test()
        return assert(basic.Main.add(1, 2) == 3);
}

