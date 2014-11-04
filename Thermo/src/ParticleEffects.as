package {
	import flash.geom.Point;  
	import org.flintparticles.common.counters.*;
	import org.flintparticles.common.displayObjects.RadialDot;
	import org.flintparticles.common.initializers.*;
	import org.flintparticles.twoD.actions.*;
	import org.flintparticles.twoD.emitters.Emitter2D;
	import org.flintparticles.twoD.initializers.*;
	import org.flintparticles.twoD.zones.*;
	
	public class ParticleEffects extends Emitter2D {
		
		public function ParticleEffects() {
			counter = new Steady( 100 );
		
			addInitializer( new ImageClass( RadialDot, [2] ) );
			addInitializer( new Position( new LineZone( new Point( -5, -5 ), new Point( 773, -5 ) ) ) );
			addInitializer( new Velocity( new PointZone( new Point( 0, 65 ) ) ) );
			addInitializer( new ScaleImageInit( 0.75, 2 ) );

			addAction( new Move() );
			addAction( new DeathZone( new RectangleZone( -10, -10, 1050, 800 ), true ) );
			addAction( new RandomDrift( 15, 15 ) );
		}
	}
}